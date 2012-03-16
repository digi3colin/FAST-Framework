package com.fastframework.net {
	import flash.events.Event;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class LoaderEvent extends Event {
		public static const READY:String = 'READY';
		public function LoaderEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
