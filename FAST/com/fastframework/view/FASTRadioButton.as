package com.fastframework.view {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.view.events.ButtonClipEvent;

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;


	/**
	 * @author colin
	 */
	public class FASTRadioButton extends FASTEventDispatcher implements IButtonClip{
		private static var groups:Array;
		
		private var view:DisplayObjectContainer;
		private var base:ButtonClip;
		private var buttonGroupName:String;

		public function FASTRadioButton(view:Sprite,parameter:String=null){
			groups||=[];

			this.view = view;

			base = new ButtonClip(view);
			base.addEventListener(ButtonClipEvent.CLICK, onClick,false,1,true);

			var para:Array;
			if(parameter==null){
				para = view.name.split('$');
			}else{
				para = parameter.split('$');
			}

			buttonGroupName = para[0];
			if(view.parent!=null)buttonGroupName = view.parent.name + para[0];

			groups[buttonGroupName] ||= new Array();
			groups[buttonGroupName][para[1]] = this;

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
				FASTRadioButton(groups[buttonGroupName][name]).base.isHighlight = false;
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

		private function onClick(e:ButtonClipEvent):void{
			this.select();
			dispatchEvent(e);
		}
		
		public function getValue():String{
			for(var name:String in groups[buttonGroupName]){
				if(FASTRadioButton(groups[buttonGroupName][name]).base.isHighlight == true)return name;
			}
			return "";
		}
	}
}
