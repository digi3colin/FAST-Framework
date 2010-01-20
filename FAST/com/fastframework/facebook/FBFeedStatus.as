package com.fastframework.facebook{
	import com.fastframework.error.SingletonError;
	import com.fastframework.event.EventDispatcherUtils;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * @author colin
	 */
	final public class FBFeedStatus extends EventDispatcher implements IFASTEventDispatcher{
		private static var ins : FBFeedStatus;

		public static function instance():FBFeedStatus {
			ins ||=new FBFeedStatus(new SingletonBlocker());
			return ins;
		}
		
		public function FBFeedStatus(p_key:SingletonBlocker) {
			if(p_key==null)throw new SingletonError(this);
		}
		
		public function when(eventType : String, whichObject : Object, callFunction : Function) : * {
			EventDispatcherUtils.when(this,eventType,whichObject,callFunction);
			return this;
		}
		
		public static const EVENT_SUBMITTED:String="onEventSubmitted";
		
		public function submitted():void{
			dispatchEvent(new Event(FBFeedStatus.EVENT_SUBMITTED));
		}
	}
}
class SingletonBlocker{}