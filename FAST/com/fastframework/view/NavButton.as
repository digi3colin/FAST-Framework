package com.fastframework.view {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.navigation.Navigation;
	import com.fastframework.navigation.NavigationEvent;
	import com.fastframework.view.events.ButtonClipEvent;
	import flash.display.SimpleButton;



	/**
	 * @author Colin
	 * decorator of ButtonClip
	 */
	final public class NavButton extends FASTEventDispatcher implements IButtonClip{
		private var base:ButtonEvt;

		public var navKey:String;
		public var targetContainer: String;

		public function NavButton(hitarea:SimpleButton,navKey:String,targetContainer:String=''){			
			base = new ButtonEvt(hitarea);
			base.when(ButtonClipEvent.CLICK, this,click);

			this.navKey = navKey;
			this.targetContainer = targetContainer;

			Navigation.instance().when(NavigationEvent.CHANGE,this,highlightButton);
		}

		private function click(e:ButtonClipEvent):void{
			Navigation.instance().changeSection(navKey, targetContainer);
		}

		private function highlightButton(e:NavigationEvent):void{
			highlightButtonByNavKey(e.navKey);
		}

		public function highlightButtonByNavKey(nav_key:String):void{
			if(nav_key==null)return;

			for(var i:int=0;i<nav_key.split("_").length;i++){
				if(this.navKey==nav_key.split("_",i+1).join("_")){
					base.select(true);
					return;
				}
			}
			base.select(false);
		}
		
		public function addElement(element : IButtonElement) : IButtonClip {
			base.addElement(element);
			return this;
		}
		
		public function getElements():Array{
			return base.getElements();
		}

		public function select(bln:Boolean=true) : IButtonClip {
			base.select(bln);
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
	}
}