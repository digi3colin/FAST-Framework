package com.fastframework.facebook {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.IFASTEventDispatcher;
	import com.fastframework.core.SingletonError;

	import flash.events.Event;


	/**
	 * @author colin
	 */
	final public class FBFeedStatus extends FASTEventDispatcher implements IFASTEventDispatcher{
		private static var ins : FBFeedStatus;
		public static function instance():FBFeedStatus {
			return ins ||new FBFeedStatus();
		}
		
		public function FBFeedStatus() {
			if(ins!=null)throw new SingletonError(this);
			ins = this;
		}
		
		public static const EVENT_SUBMITTED:String="onEventSubmitted";
		
		public function submitted():void{
			dispatchEvent(new Event(FBFeedStatus.EVENT_SUBMITTED));
		}
	}
}
class SingletonBlocker{}