package com.fastframework.net {
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class LoaderEvent extends Event {
		public static const COMPLETE:String 	= Event.COMPLETE;
		public static const IO_ERROR:String 	= IOErrorEvent.IO_ERROR;
		public static const HTTP_STATUS:String 	= HTTPStatusEvent.HTTP_STATUS;
		public static const OPEN:String 		= Event.OPEN;
		public static const PROGRESS:String		= ProgressEvent.PROGRESS;
		public static const UNLOAD:String		= Event.UNLOAD;
		public static const READY:String 		= 'READY';

		public function LoaderEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}