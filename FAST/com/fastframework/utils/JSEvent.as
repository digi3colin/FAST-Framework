package com.fastframework.utils{
	import flash.events.Event;

	/**
	 * @author colin
	 */
	final public class JSEvent extends Event {
		public static const CALLBACK:String='onCallback';
		
		public var msg:String;
		public function JSEvent(type : String, msg:String, bubbles : Boolean = false, cancelable : Boolean = false) {
			this.msg = msg;
			super(type, bubbles, cancelable);
		}
	}
}
