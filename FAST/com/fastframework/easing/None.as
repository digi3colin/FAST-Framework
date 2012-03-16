package com.fastframework.easing{
//****************************************************************************
//Copyright (C) 2003-2005 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************
	
	final public class None {
		public static function easeNone (t:Number, b:Number, c:Number, d:Number):Number {
			return c*t/d + b;
		}
		public static function easeIn (t:Number, b:Number, c:Number, d:Number):Number {
			return c*t/d + b;
		}
		public static function easeOut (t:Number, b:Number, c:Number, d:Number):Number {
			return c*t/d + b;
		}
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number):Number {
			return c*t/d + b;
		}
	}
}