package com.fastframework.view {
	import com.fastframework.core.navigation.Navigation;
	import com.fastframework.core.navigation.NavigationEvent;
	import com.fastframework.view.events.ButtonClipEvent;
	import flash.display.SimpleButton;
	import flash.events.Event;


	/**
	 * @author Colin
	 * decorator of ButtonClip
	 */
	final public class NavButton implements IButtonClip, IFASTEventDispatcher{
		private var base:ButtonEvt;
		private var nav:Navigation;
	
		public var navKey:String;
		public var targetContainer: String;

		public function NavButton(hitarea:SimpleButton,navKey:String,targetContainer:String=null){			
			base = new ButtonEvt(hitarea);
			base.when(ButtonClipEvent.CLICK, this,click);

			this.navKey = navKey;
			this.targetContainer = targetContainer;

			nav = Navigation.instance().when(NavigationEvent.CHANGE,this,highlightButton);
		}

		private function click(e:ButtonClipEvent):void{
			var nav:Navigation = Navigation.instance();
			nav.clearNavStackRequests();
			nav.changeSection(navKey, targetContainer, false, base.getBase());
		}

		private function highlightButton(e:NavigationEvent):void{
			highlightButtonByNavKey(e.navKey);
		}

		public function highlightButtonByNavKey(nav_key:String):void{
			if(nav_key==null)return;

			for(var i:int=0;i<nav_key.split("_").length;i++){
				if(this.navKey==nav_key.split("_",i+1).join("_")){
					base.isHighlight = true;
					return;
				}
			}
			base.isHighlight = false;		
		}
		
		public function addElement(element : IButtonElement) : IButtonClip {
			base.addElement(element);
			return this;
		}
		
		public function getElements():Array{
			return base.getElements();
		}
		
		public function get isHighlight():Boolean{
			return base.isHighlight;
		}
		
		public function select() : IButtonClip {
			base.select();
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
		
		public function when(eventType : String, whichObject : Object, callFunction : Function) : * {
			base.when(eventType,whichObject,callFunction);
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
			base.addEventListener(type, listener,useCapture,priority,useWeakReference);
		}
	}
}