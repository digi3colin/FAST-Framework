package tests.core {
	import asunit.framework.TestCase;

	import com.fastframework.view.ButtonClip;
	import com.fastframework.view.IButtonClip;
	import com.fastframework.view.events.ButtonClipEvent;

	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * @author Colin
	 */
	public class ButtonClipTest extends TestCase {
		private var asyncCallBack:Function;
		private var instance:ButtonClip;
		private var btn:SimpleButton;
		
		protected override function setUp():void{
			var hitArea:Sprite = new Sprite();
			hitArea.graphics.beginFill(0, 1);
			hitArea.graphics.drawRect(0, 0, 100, 100);
			btn = new SimpleButton(null,null,null,hitArea);
			var mc_button:Sprite = new Sprite();
			mc_button.addChild(btn);

			instance = new ButtonClip(mc_button);
		}
		
		protected override function tearDown():void{
			btn = null;
			instance = null;
		}
		
		public function testInstance():void{
			assertTrue(instance is ButtonClip);
		}

		public function testMouseDown():void{
			asyncCallBack = addAsync(postMouseDown);
			instance.addEventListener(MouseEvent.MOUSE_DOWN,asyncCallBack);
			btn.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN, true, false, 0, 0, null, false, false, false, true, 0));
		}

		private function postMouseDown(e:Event):void{
			assertEquals(MouseEvent.MOUSE_DOWN, e.type);
			assertEquals(ButtonClipEvent.MOUSE_DOWN, e.type);
			assertEquals(instance, e.target);
			assertTrue(e is Event);
		}

		public function testSelect():void{
			asyncCallBack = addAsync(postTestSelect);
			instance.addEventListener(ButtonClipEvent.SELECT,asyncCallBack);
			instance.select(true);
		}

		private function postTestSelect(e:Event):void{
			assertEquals(Event.SELECT, e.type);
			assertEquals(ButtonClipEvent.SELECT, e.type);
			assertEquals(instance, e.target);
			assertTrue(e is Event);
			assertEquals(true, instance.getSelect());
		}

		public function testReset():void{
			asyncCallBack = addAsync(postTestReset);
			instance.addEventListener(ButtonClipEvent.RESET,asyncCallBack);
			instance.select(false);
		}

		private function postTestReset(e:Event):void{
			assertEquals(ButtonClipEvent.RESET, e.type);
			assertEquals(instance, e.target);
			assertTrue(e is Event);
			assertEquals(false, instance.getSelect());
		}

		public function testElement():void{
			var element:ButtonElement = new ButtonElement();
			instance.addElement(element);
			instance.select(true);
			
			assertEquals(true, IButtonClip(element.target).getSelect());
		}

		public function testAddElement():void{
			var element:ButtonElement = new ButtonElement();
			instance.addElement(element);
			instance.addElement(element);
			
			var count:int=0;
			var obj:*;
			for(obj in instance.getElements()){
				count++;
				assertEquals(element, obj);
				assertTrue(obj is ButtonElement);
			}
			
			assertEquals(1,count);

			instance.addElement(new ButtonElement());
			instance.addElement(new ButtonElement());

			count=0;
			obj = null;
			for(obj in instance.getElements()){
				count++;
				assertTrue(obj is ButtonElement);
			}
			
			assertEquals(3,count);
		}
	}
}


import com.fastframework.view.IButtonElement;

import flash.events.Event;
class ButtonElement implements IButtonElement{
	public var target:*;

	public function buttonOver(e : Event) : void {
		this.target = e.target;
	}

	public function buttonOut(e : Event) : void {
		this.target = e.target;
	}

	public function buttonDown(e : Event) : void {
		this.target = e.target;
	}

	public function buttonReset(e : Event) : void {
		this.target = e.target;
	}
}