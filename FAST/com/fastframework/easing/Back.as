package com.fastframework.easing{
//****************************************************************************
//Copyright (C) 2003-2005 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

	final public class Back {
		public static function easeIn (t:Number, b:Number, c:Number, d:Number, s:Number=1.70158):Number {
			return c*(t/=d)*t*((s+1)*t - s) + b;
		}
		public static function easeOut (t:Number, b:Number, c:Number, d:Number, s:Number=1.70158):Number {
			return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
		}
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number, s:Number=1.70158):Number {
			if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
			return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
		}
	}
}