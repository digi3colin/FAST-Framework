package {
	import com.fastframework.core.FASTEventDispatcher;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class MainEventDispatcher extends Sprite{
		private var ed:FASTEventDispatcher;
		private var ed2:FASTEventDispatcher;
		private var evt:Event;
		private var n:int = 0;
		
		public function MainEventDispatcher(){
			this.stage.addEventListener(MouseEvent.CLICK, click);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, clean);

			evt = new Event(Event.CHANGE);
			ed = new FASTEventDispatcher();
			ed2 = new FASTEventDispatcher();

			ed.once(Event.CHANGE,testOnce);
			ed2.once(Event.CHANGE,testOnce);

			var st:int = getTimer();
			var count:int = 10;
			trace('b1');
			for(var i:int=0;i<count;i++){
				dispatch();
			}
			trace('time:'+(getTimer()-st));
			trace('n:'+n+(n==count?'pass':'fail'));
			if(n!=count)throw new Error('result mismatch');
		}

		private function clean(e:KeyboardEvent):void{
			ed = null;
			ed2 = null;
			evt = null;
		}

		private function click(e:Event):void{
			dispatch();
		}

		private function dispatch():void{
			ed.dispatchEvent(evt);
		}

		private function testOnce(e:Event):void{
			n++;
			ed.once(Event.CHANGE,testOnce);
		}
	}
}
