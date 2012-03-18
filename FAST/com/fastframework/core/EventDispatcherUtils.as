package com.fastframework.core {
	import flash.events.Event;
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
		public function when(ins:IFASTEventDispatcher,eventType : String, whichObject : Object, callback : Function):void{
			ins.addEventListener(eventType, callback, false, 0, true);
			whichObject;
		}
		
		public function once(ins:IFASTEventDispatcher, eventType:String, whichObject:Object, callback:Function):*{
			ins.addEventListener(eventType,onceHandler(callback));
			whichObject;
			return this;
		}

		private function onceHandler(callback:Function):Function{
	        return function (event:Event):void
	        {
	            var eventDispatcher:IFASTEventDispatcher = IFASTEventDispatcher(event.target);
	            eventDispatcher.removeEventListener(event.type, arguments['callee']);
	            callback(event);
	        };
		}
	}
}