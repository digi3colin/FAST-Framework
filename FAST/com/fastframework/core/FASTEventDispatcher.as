package com.fastframework.core {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * @author colin
	 */
	public class FASTEventDispatcher extends EventDispatcher implements IFASTEventDispatcher {
		public function when(eventType : String, whichObject : Object, callback : Function) : * {
			this.addEventListener(eventType, callback, false, 0, true);
			return this;
		}

		public function once(eventType:String, whichObject:Object, callback:Function):*{
			this.addEventListener(eventType,onceHandler(callback));
			return this;
		}

		private function onceHandler(callback:Function):Function{
	        return function (event:Event):void
	        {
	            var eventDispatcher:IEventDispatcher = IEventDispatcher(event.target);
	            eventDispatcher.removeEventListener(event.type, arguments['callee']);
	            callback(event);
	        };
		}
	}
}
