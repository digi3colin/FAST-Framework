package com.fastframework.locale {
	import com.fastframework.event.EventDispatcherUtils;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * @author colin
	 */
	final public class Language extends EventDispatcher implements IFASTEventDispatcher{

		private static var ins:Language;
		public static function instance():Language {
			ins ||=new Language(new SingletonBlocker());
			return ins;
		}

		public static var LANG_EN:Array = ["en","eng"];
		public static var LANG_CN:Array = ["zh-CN","schi"];
		
		private var currentLang:Array = LANG_EN;
		
		public function Language(p_key:SingletonBlocker) {}
		
		public function set lang(strLang:Array):void{
			currentLang = strLang[0];
			dispatchEvent(new Event(Event.CHANGE));
		}
	
		public function get lang():String{
			return currentLang[0];
		}
		
		public function get id():String{
			return currentLang[1];
		}
		
		public function when(eventType : String, whichObject : Object, callFunction : Function) : * {
			EventDispatcherUtils.when(this, eventType, whichObject, callFunction);
			return this;
		}
	}
}

internal class SingletonBlocker {}