package com.fastframework.facebook{
	import com.fastframework.core.EventDispatcherUtils;
	import com.fastframework.core.SingletonError;
	import flash.events.Event;
	import flash.events.EventDispatcher;


	/**
	 * @author colin
	 */
	final public class FBFeedStatus extends EventDispatcher implements IFASTEventDispatcher{
		private static var ins : FBFeedStatus;
		public static function instance():FBFeedStatus {
			return ins ||new FBFeedStatus();
		}
		
		public function FBFeedStatus() {
			if(ins!=null)throw new SingletonError(this);
			ins = this;
		}
		
		public function when(eventType : String, whichObject : Object, callFunction : Function) : * {
			EventDispatcherUtils.instance().when(this,eventType,whichObject,callFunction);
			return this;
		}
		
		public static const EVENT_SUBMITTED:String="onEventSubmitted";
		
		public function submitted():void{
			dispatchEvent(new Event(FBFeedStatus.EVENT_SUBMITTED));
		}
	}
}
class SingletonBlocker{}