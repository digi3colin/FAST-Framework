package com.fastframework.view.events {
	import flash.events.Event;

	/**
	 * @author digi3colin
	 */
	public class ActionEvent extends Event {
		public static const ACTION: String="action";

		public var action_name:String="";
		public var callback:Function;
		public var dispatcher:Object;

		public function ActionEvent(type : String, action_name:String, dispatcher:Object=null, callback:Function=null, bubbles : Boolean = false, cancelable : Boolean = false) {
			this.action_name = action_name;
			this.callback = callback;
			this.dispatcher = dispatcher;
			super(type, bubbles, cancelable);
		}
	}
}
