package tests.core {
	import asunit.framework.TestCase;

	import com.fastframework.core.FASTEventDispatcher;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * @author colin
	 */
	public class FASTEventDispatcherTest extends TestCase {
		private var instance:FASTEventDispatcher;
		protected override function setUp():void{
			instance = new FASTEventDispatcher();
		}
		
		protected override function tearDown():void{
			instance = null;
		}
		
		public function testInstance():void{
			assertTrue(instance is FASTEventDispatcher);
			assertTrue(instance is EventDispatcher);
		}
		
		private var asyncCallBack:Function;
		public function testAddEventListener():void{
			asyncCallBack = addAsync(postAddEventListener);
			instance.addEventListener(Event.CHANGE,asyncCallBack);
			instance.dispatchEvent(new Event(Event.CHANGE));
			
		}

		private function postAddEventListener(e:Event):void{
			assertEquals(e.target,instance);
			assertEquals(e.type, Event.CHANGE);

			assertTrue(instance.hasEventListener(Event.CHANGE));
			instance.removeEventListener(Event.CHANGE, asyncCallBack);
			assertFalse(instance.hasEventListener(Event.CHANGE));
		}
		
		private var dispatchCount:int=0;
		public function testWhen():void{
			assertFalse('make sure no event listener attached',instance.hasEventListener(Event.CHANGE));
			dispatchCount=0;
			//test when, it should not retain the callback if tempObject removed, cannot test..

			//test when can listen the event until remove eventlistener

			instance.when(Event.CHANGE, postWhenChange);
			instance.dispatchEvent(new Event(Event.CHANGE));
			instance.dispatchEvent(new Event(Event.CHANGE));
			instance.dispatchEvent(new Event(Event.CHANGE));
			instance.dispatchEvent(new Event(Event.CLOSE));//this should be no respond
			instance.dispatchEvent(new Event(Event.CHANGE));
			instance.removeEventListener(Event.CHANGE, postWhenChange);
			instance.dispatchEvent(new Event(Event.CHANGE));
		}

		private function postWhenChange(e:Event):void{
			assertEquals(e.type,Event.CHANGE);
			assertTrue(dispatchCount++<4);
		}

		public function testOnce():void{
			assertFalse(instance.hasEventListener(Event.CHANGE));
			dispatchCount = 0;

			instance.once(Event.CHANGE, postOnce);
			instance.dispatchEvent(new Event(Event.CHANGE));
			instance.dispatchEvent(new Event(Event.CHANGE));


			assertEquals(1,dispatchCount);
		}

		private function postOnce(e:Event):void{
			assertTrue(dispatchCount==0);
			dispatchCount++;
		}
		
		public function testAddTwice():void{
			assertFalse(instance.hasEventListener(Event.CHANGE));
			dispatchCount = 0;

			instance.addEventListener(Event.CHANGE, postAddTwice);
			instance.dispatchEvent(new Event(Event.CHANGE));
			instance.dispatchEvent(new Event(Event.CHANGE));

			assertEquals(2,dispatchCount);
		}
		
		private function postAddTwice(e:Event):void{
			dispatchCount++;
		}
	}
}
