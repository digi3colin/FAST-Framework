package com.fastframework.locale {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.IFASTEventDispatcher;
	import com.fastframework.core.SingletonError;

	import flash.events.Event;


	/**
	 * @author colin
	 */
	final public class Language extends FASTEventDispatcher implements IFASTEventDispatcher{
		private static var ins:Language;
		public static function instance():Language {
			return ins || new Language;
		}

		public static var LANG_EN:Array = ["en","eng"];
		public static var LANG_SC:Array = ["zh-CN","sc"];
		public static var LANG_TC:Array = ["zh-TW","tc"];
		
		private var currentLang:Array = LANG_EN;
		
		public function Language() {
			if(ins!=null){throw new SingletonError(this);}ins = this;
		}

		public function set langPack(strLang:Array):void{
			currentLang = strLang[0];
			dispatchEvent(new Event(Event.CHANGE));
		}
	
		public function get lang():String{
			return currentLang[0];
		}
		
		public function get id():String{
			return currentLang[1];
		}
	}
}