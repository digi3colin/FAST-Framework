package com.fastframework.view {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.view.events.ButtonClipEvent;

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.utils.Dictionary;


	/**
	 * @author colin
	 */
	public class FASTRadioButton extends FASTEventDispatcher implements IButtonClip{
		private static var groups:Dictionary;
		
		private var view:DisplayObjectContainer;
		private var base:ButtonClip;
		private var buttonGroupName:String;
		private var buttonName:String;
		private var group:Dictionary;

		public function FASTRadioButton(view:Sprite,parameter:String=null){
			groups||=new Dictionary(true);

			this.view = view;

			base = new ButtonClip(view);
			base.when(ButtonClipEvent.CLICK, this, onClick);
			base.when(ButtonClipEvent.SELECT, this, onSelect);

			var para:Array;
			if(parameter==null){
				//no parameter supplied. use sprite name;
				para = view.name.split('$');
				
				//if sprite have parent, append the parent's name to make it more unique;
				if(view.parent!=null)para[0] = view.parent.name+para[0];

			}else{
				para = parameter.split('$');
			}

			buttonGroupName = para[0];
			buttonName = para[1];
			if(view.parent!=null)buttonGroupName = view.parent.name + para[0];

			groups[buttonGroupName] ||= new Dictionary(true);
			groups[buttonGroupName][buttonName] = this;

			group = groups[buttonGroupName];
		}

		private function onSelect(e:ButtonClipEvent):void{
			dispatchEvent(new ButtonClipEvent(e.type,e.highlight,e.bubbles,e.cancelable));		
		}

		private function onClick(e:ButtonClipEvent):void{
			this.select(true);
			dispatchEvent(new ButtonClipEvent(e.type,e.highlight,e.bubbles,e.cancelable));
		}
		
		public function addElement(element : IButtonElement) : IButtonClip {
			base.addElement(element);
			return this;
		}
		
		public function getElements() : Array {
			return base.getElements();
		}

		public function select(bln:Boolean = true) : IButtonClip {
			if(bln==true){
				Dictionary(groups[buttonGroupName])['selected']=this;
			}

			for each(var btn:FASTRadioButton in groups[buttonGroupName]){
				if(btn==this)continue;
				btn.base.select(false);
			}
			this.base.select(bln);
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

		public function getValue():String{
			if(group['selected']==null)return "";
			return FASTRadioButton(group['selected']).buttonName;
		}
	}
}
