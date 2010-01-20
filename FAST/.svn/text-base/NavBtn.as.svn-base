package {	import com.fastframework.navigation.Navigation;	import com.fastframework.utils.MovieClipTools;	import com.fastframework.utils.StringUtils;	import com.fastframework.utils.SystemUtils;	import com.fastframework.view.NavButton;	import flash.display.DisplayObjectContainer;	import flash.events.Event;	/**	 * @author Colin	 */
	final public class NavBtn implements IButtonClip{
		public static var FILEPREFIX:String = 'FILEPREFIX';		private var base:NavButton;

		public function NavBtn(mc:DisplayObjectContainer){			var n:String = mc.name;			n = StringUtils.replace(mc.name, FILEPREFIX, SystemUtils.getMovieFileName(mc, false));
			var para:Array = n.split("$");
			base = new NavButton(MovieClipTools.findButton(mc),para[1],para[2]);			base.highlightButtonByNavKey(Navigation.instance().getCurrentNavKey());
		}

		public function addElement(element : IButtonElement) : IButtonClip {
			base.addElement(element);			return this;
		}
			public function getElements():Array{			return base.getElements();		}
		public function select() : IButtonClip {
			base.select();			return this;
		}			public function when(eventType : String, whichObject : Object, callFunction : Function) : * {		    addEventListener(eventType, callFunction, false, 0, true);		    return this;		}		public function setMouseOverDelay(miniSecond : int) : IButtonClip {			base.setMouseOverDelay(miniSecond);			return this;		}				public function setMouseOutDelay(miniSecond : int) : IButtonClip {			base.setMouseOutDelay(miniSecond);			return this;		}				public function clearMouseOver() : IButtonClip {			base.clearMouseOver();			return this;		}				public function clearMouseOut() : IButtonClip {			base.clearMouseOut();			return this;		}				public function dispatchEvent(event : Event) : Boolean {
			return base.dispatchEvent(event);		}				public function hasEventListener(type : String) : Boolean {
			return base.hasEventListener(type);		}				public function willTrigger(type : String) : Boolean {
			return base.willTrigger(type);		}				public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void {			base.removeEventListener(type, listener,useCapture);		}				public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void {			base.addEventListener(type, listener,useCapture,priority,useWeakReference);		}
	}}
