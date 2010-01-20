package com.fastframework.net {
	import flash.events.Event;
	import flash.events.ProgressEvent;

	/**
	 * @author Colin
	 */
	final public class LoaderEvent extends Event{
		public var targetContainer: Object;
		public static const COMPLETE : String = Event.COMPLETE;
		public static const PROGRESS : String = ProgressEvent.PROGRESS;
		public static const OPEN     : String = Event.OPEN;
		public static const READY    : String = Event.ADDED_TO_STAGE;

		public function LoaderEvent(type:String,targetContainer:Object="",bubbles:Boolean=false,cancelable:Boolean=false){
			super(type, bubbles, cancelable);
			this.targetContainer=targetContainer;
		}
	}
}