package com.fastframework.event {
	import flash.events.IEventDispatcher;

	/**
	 * @author colin
	 */
	final public class EventDispatcherUtils{
		public static function when(ins:IEventDispatcher,eventType : String, whichObject : Object, callFunction : Function):void{
			ins.addEventListener(eventType, callFunction, false, 0, true);
			whichObject;
		}
	}
}
