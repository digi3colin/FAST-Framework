package com.fastframework.core {
	import flash.events.EventDispatcher;

	/**
	 * @author colin
	 */
	public class FASTEventDispatcher extends EventDispatcher implements IFASTEventDispatcher {
		public function when(eventType : String, whichObject : Object, callback : Function) : * {
			EventDispatcherUtils.instance().when(this, eventType, whichObject, callback);
			return this;
		}

		public function once(eventType:String, whichObject:Object, callback:Function):*{
			EventDispatcherUtils.instance().once(this, eventType, whichObject, callback);
			return this;
		}
	}
}
