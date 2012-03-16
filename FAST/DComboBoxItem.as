package {
	import com.fastframework.core.EventDispatcherUtils;
	import com.fastframework.utils.MovieClipTools;
	import com.fastframework.view.events.ActionEvent;
	import com.fastframework.view.events.ButtonClipEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;


	/**
	 * @author colin
	 */
	public class DComboBoxItem extends MovieClip implements IFASTEventDispatcher{		
		private var label:TextField;
		private var btn:ButtonClip;
		public function DComboBoxItem() {
			super();
			label = MovieClipTools.findTextField(this);
			btn = new ButtonClip(this);

			btn.when(ButtonClipEvent.CLICK, this, onItemClick);
		}

		private function onItemClick(e:ButtonClipEvent):void{
			dispatchEvent(new Event(Event.SELECT));
			dispatchEvent(new ActionEvent(ActionEvent.ACTION,'select'));
		}

		public function setLabelText(str:String):void{
			if(label == null)return;
			label.text = str;
		}

		public function getButtonClip():ButtonClip{
			return btn;
		}

		public function when(eventType : String, whichObject : Object, callFunction : Function) : * {
			EventDispatcherUtils.instance().when(this, eventType, whichObject, callFunction);
			return this;
		}
	}
}
