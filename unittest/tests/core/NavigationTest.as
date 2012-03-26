package tests.core {
	import asunit.framework.TestCase;
	import com.fastframework.navigation.NavStackRequest;
	import com.fastframework.navigation.Navigation;
	import com.fastframework.navigation.NavigationEvent;

	/**
	 * @author colin
	 */
	public class NavigationTest extends TestCase{
		private var instance:Navigation;
		protected override function setUp():void {
			instance = Navigation.instance();
		}

		protected override function tearDown():void {
			instance = null;
			asyncEventChange = null;
		}
		
		public function testInstance():void {
			assertTrue(instance is Navigation);
		}



		private var navKey:String = '1_0';
		private var targetContainer:String = 'top';
		private var asyncEventChange:Function;
		public function testEventChange():void{
			asyncEventChange = addAsync(postEventChange);
			
			instance.once(NavigationEvent.CHANGE, asyncEventChange);
			instance.changeSection(navKey,targetContainer);
		}

		private function postEventChange(e:NavigationEvent):void{
			assertEquals('test event target',			e.target,				instance);
			assertEquals('test event navigation key',	e.navKey,				navKey);
			assertEquals('test navigation key',			instance.getNavKey(),	e.navKey);
			assertEquals('test event target container',	e.targetContainer,		targetContainer);
		}

		public function testNavStackRequest():void{
			navKeyToEvaluate = '1_1';
			asyncEventChange = addAsync(postNavStackRequest);
			instance.when(NavigationEvent.CHANGE, asyncEventChange);
			instance.changeSections([
						new NavStackRequest(navKeyToEvaluate),
						new NavStackRequest(navKey)
						]);
		}

		private var navKeyToEvaluate:String;
		private function postNavStackRequest(e:NavigationEvent):void{
			//the instance.getNavKey should be last navKey in the stack
			assertEquals(instance.getNavKey(),navKey);

			//the e.navKey should be different on every event dispatch;
			assertEquals(e.navKey,navKeyToEvaluate);

			//the action after receive change event;
			switch(navKeyToEvaluate){
				case('1_1'):
					navKeyToEvaluate = navKey;
					instance.nextSection();
					break;
				case(navKey):
					instance.removeEventListener(e.type, asyncEventChange);
			}
		}

	}
}
