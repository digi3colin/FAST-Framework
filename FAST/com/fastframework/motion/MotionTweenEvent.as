package com.fastframework.motion {	import flash.events.Event;
	
	/**	 * @author colin	 */	final public class MotionTweenEvent extends Event {		public static const TWEENING:String = "tweening";		public static const START:String    = "start";		public static const END:String      = "end";				public function MotionTweenEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {			super(type, bubbles, cancelable);		}
	}}