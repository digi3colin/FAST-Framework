package {
	import com.fastframework.core.EventDispatcherUtils;
	import com.fastframework.motion.MotionTween;
	import com.fastframework.utils.MovieClipTools;
	import com.fastframework.view.ButtonEvt;
	import com.fastframework.view.events.ButtonClipEvent;

	import flash.display.DisplayObjectContainer;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * @author Colin
 */
	final public class ButtonClip extends EventDispatcher implements IButtonClip{
		private var motion:MotionTween;
		
		public var _hitArea:SimpleButton;
		private var base:ButtonEvt;
		private var count:int;
		private var _enabled : Boolean = true;
		private var baseIsDown:Boolean = false;
		private var view:DisplayObjectContainer;

        public var repeatPerFrame:int = 0;

		public function ButtonClip(mc:DisplayObjectContainer) {
			view = mc;
		    _hitArea = MovieClipTools.findButton(mc);

		    base = new ButtonEvt(_hitArea);
		    base.when(ButtonClipEvent.MOUSE_DOWN,this,down);
		    base.when(ButtonClipEvent.MOUSE_UP,this,up);
		    mc.addEventListener(Event.ENTER_FRAME, loop);
		    motion = new MotionTween(mc);

			//fix the event in target
			base.when(ButtonClipEvent.MOUSE_OVER, this,forwardEvent);
			base.when(ButtonClipEvent.MOUSE_OUT, this,forwardEvent);
			base.when(ButtonClipEvent.ROLL_OVER, this,forwardEvent);
			base.when(ButtonClipEvent.ROLL_OUT, this,forwardEvent);
			base.when(ButtonClipEvent.MOUSE_DOWN, this,forwardEvent);
			base.when(ButtonClipEvent.MOUSE_UP, this,forwardEvent);
			base.when(ButtonClipEvent.RESET, this,forwardEvent);
			base.when(ButtonClipEvent.CLICK, this,forwardEvent);
			base.when(ButtonClipEvent.SELECT, this,forwardEvent);
		}
		
		private function forwardEvent(e:ButtonClipEvent):void{
			this.dispatchEvent(e);
		}
		
		public function addElement(element : IButtonElement) : IButtonClip {
	        base.addElement(element);
	        return this;
		}
		
		public function getElements():Array{
	        return base.getElements();
		}
		
		public function select() : IButtonClip {
	        base.select();
	        return this;
		}

		public function when(eventType : String, whichObject : Object, callFunction : Function) : * {
			EventDispatcherUtils.instance().when(this, eventType, whichObject, callFunction);
			return this;
		}
		
		public function setMouseOverDelay(miniSecond : int) : IButtonClip {
	        base.setMouseOverDelay(miniSecond);
	        return this;
		}
		
		public function setMouseOutDelay(miniSecond : int) : IButtonClip {
	        base.setMouseOutDelay(miniSecond);
	        return this;
		}
		
		public function clearMouseOver() : IButtonClip {
	        base.clearMouseOver();
	        return this;
		}

		public function clearMouseOut() : IButtonClip {
	        base.clearMouseOut();
	        return this;
		}
		
		public function setEnabled(value:Boolean):void{
			view.visible = value;
			_enabled = value;
		}
		
		public function getEnabled():Boolean{
	        return _enabled;
		}
		
		public function get isHighlight():Boolean{
			return base.isHighlight;
		}
		
		public function set isHighlight(value:Boolean):void{
			base.isHighlight = value;
		}

		private function loop(e:Event):void{
			if(baseIsDown == false)return;
			if(repeatPerFrame<=0)return;
			if(count==0){
				//trace('up');
				if(_enabled==true){
					count = repeatPerFrame;
					//trace('down');
				}
			}
			count--;
		}
		
		private function down(e:ButtonClipEvent):void{
		    baseIsDown = true;
		    count=repeatPerFrame;
		}
		
		private function up(e:ButtonClipEvent):void{
		    baseIsDown = false;
		}
		
		public function getView():DisplayObjectContainer{
			return view;
		}
		
		public function set alpha(value:Number):void{
			motion.startTween({a:value});
		}
	}
}