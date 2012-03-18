package com.fastframework.view {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.IFASTEventDispatcher;
	import com.fastframework.core.utils.MovieClipTools;
	import com.fastframework.view.events.ActionEvent;
	import com.fastframework.view.events.ButtonClipEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;




	/**
	 * @author colin
	 */
	public class DComboBoxItem extends FASTEventDispatcher implements IFASTEventDispatcher{		
		private var label:TextField;
		private var base:ButtonClip;
		public function DComboBoxItem(view:Sprite) {
			label = MovieClipTools.findTextField(view);
			base = new ButtonClip(view);

			base.when(ButtonClipEvent.CLICK, this, onItemClick);

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

		private function onItemClick(e:ButtonClipEvent):void{
			dispatchEvent(new Event(Event.SELECT));
			dispatchEvent(new ActionEvent(ActionEvent.ACTION,'select'));
		}

		public function setLabelText(str:String):void{
			if(label == null)return;
			label.text = str;
		}
	}
}
