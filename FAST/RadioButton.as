package {

	/**
	 * @author colin
	 */
	import com.fastframework.view.events.ButtonClipEvent;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	/**
	 * @author colin
	 */
	public class RadioButton implements IButtonClip, IFASTEventDispatcher{
		private static var groups:Array;
		
		private var view:DisplayObjectContainer;
		private var base:ButtonClip;
		private var buttonGroupName:String;
		private var para:Array;
		public function RadioButton(mc:DisplayObjectContainer){
			groups||=[];

			view = mc;
			view.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage,false,0,true);
			view.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage,false,0,true);
			base = new ButtonClip(mc);
			base.addEventListener(ButtonClipEvent.CLICK, onClick,false,1,true);
			onAddedToStage();
		}

		private function onAddedToStage(...e):void{
			para = view.name.split("$");
			buttonGroupName = para[0];
			if(view.parent!=null)buttonGroupName = view.parent.name + para[0];

			groups[buttonGroupName] ||= new Array();
			groups[buttonGroupName][para[1]] = this;
		}

		private function onRemoveFromStage(e:Event):void{
			groups[buttonGroupName][para[1]] = null;
		}
		
		public function addElement(element : IButtonElement) : IButtonClip {
			base.addElement(element);
			return this;
		}
		
		public function getElements() : Array {
			return base.getElements();
		}
		
		public function select() : IButtonClip {
			base.select();

			for(var name:String in groups[buttonGroupName]){
				RadioButton(groups[buttonGroupName][name]).base.isHighlight = false;
			}
			
			base.isHighlight = true;
			return this;
		}
		
		public function setMouseOverDelay(miniSecond : int) : IButtonClip {
			base.setMouseOverDelay(miniSecond);
			return this;
		}
		
		public function clearMouseOver() : IButtonClip {
			base.clearMouseOut();
			return this;
		}
		
		public function setMouseOutDelay(miniSecond : int) : IButtonClip {
			base.setMouseOutDelay(miniSecond);
			return this;
		}
		
		public function clearMouseOut() : IButtonClip {
			base.clearMouseOut();
			return this;
		}
		
		public function when(eventType : String, whichObject : Object, callFunction : Function) : * {
			base.when(eventType, whichObject, callFunction);
			return this;
		}
		
		public function dispatchEvent(event : Event) : Boolean {
			return base.dispatchEvent(event);
		}
		
		public function hasEventListener(type : String) : Boolean {
			return base.hasEventListener(type);
		}
		
		public function willTrigger(type : String) : Boolean {
			return base.willTrigger(type);
		}
		
		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void {
			base.removeEventListener(type, listener,useCapture);
		}
		
		public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void {
			base.addEventListener(type,listener,useCapture,priority,useWeakReference);
		}

		private function onClick(e:ButtonClipEvent):void{
			this.select();
		}
		
		public function getValue():String{
			for(var name:String in groups[buttonGroupName]){
				if(RadioButton(groups[buttonGroupName][name]).base.isHighlight == true)return name;
			}
			return "";
		}
	}
}
