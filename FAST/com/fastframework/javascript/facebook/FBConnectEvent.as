package com.fastframework.javascript.facebook {
	import flash.events.Event;

	/**
	 * @author colin
	 */
	final public class FBConnectEvent extends Event {
		public static const CALLBACK:String='onCallback';
		
		public var msg:String;
		public function FBConnectEvent(type : String, msg:String, bubbles : Boolean = false, cancelable : Boolean = false) {
			this.msg = msg;
			super(type, bubbles, cancelable);
		}
	}
}
