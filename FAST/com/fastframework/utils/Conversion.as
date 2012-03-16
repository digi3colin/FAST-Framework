package com.fastframework.utils {
	import flash.geom.ColorTransform;	
	
	/**
	 * @author colin
	 */
	final public class Conversion {
		static public var toDeg:Number = 180/Math.PI;
		static public var toRad:Number = Math.PI/180;
		
		static public function hexToColor(argHex:Number,argAlpha:Number=1):ColorTransform{// change hex value to color transform object
			return CSSColor.toColorTransform(argHex, argAlpha);
		}
		
		static public function radianToDegree(r:Number):Number{
			return r*toDeg;
		}
		
		static public function degreeToRadian(d:Number):Number{
			return d*toRad;
		}
		
		static public function thousandSeperator(num:Number):String{
			var values:Array = num.toString().split(".");
			var sValue:String = values[0];
			var sRegExp:RegExp = new RegExp('(-?[0-9]+)([0-9]{3})');
			
			while(sRegExp.test(sValue)) {
				sValue = sValue.replace(sRegExp, '$1,$2'); 
			} 
			return sValue+ ((values[1]==null)?"":("."+values[1]));
		}
	}
}
