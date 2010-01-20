package com.fastframework.motion {
	import flash.geom.ColorTransform;

	/**
	 * @author colin
	 */
	final internal class MotionTransform {
		public var x:Number;
		public var y:Number;
		public var xs:Number;
		public var ys:Number;
		public var r:Number;
		public var c:ColorTransform = new ColorTransform();
		
		public function toString():String{
			return c.toString();
		}
	}
}
