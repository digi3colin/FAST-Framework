package com.fastframework.core {

	/**
	 * @author colin
	 */
	final public class EventDispatcherUtils{
		private static var ins:EventDispatcherUtils;
		public static function instance():EventDispatcherUtils {
			return ins ||new EventDispatcherUtils();

		}

		public function EventDispatcherUtils() {
			if(ins!=null)throw new SingletonError(this);
			ins = this;
		}
		public function when(ins:IFASTEventDispatcher,eventType : String, whichObject : Object, callFunction : Function):void{
			ins.addEventListener(eventType, callFunction, false, 0, true);
			whichObject;
		}
	}
}