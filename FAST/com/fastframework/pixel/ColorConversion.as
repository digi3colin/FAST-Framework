package com.fastframework.pixel {

	/**
	 * @author colin
	 */
	final public class ColorConversion {
		public static function luma(color:int):Number{
			var r:int = color >> 16;
			var g:int = (color ^ (r << 16)) >> 8;
			var b:int = (color ^ (r << 16)) ^ (g << 8);

			return 0.2126*r + 0.7152*g + 0.0722*b;		
		}
		
		public static function grayscale(color:int):int{
			var r:int = color >> 16;
			var g:int = (color ^ (r << 16)) >> 8;
			var b:int = (color ^ (r << 16)) ^ (g << 8);
			return 11*r + 16*g + 5*b;
		}
		
		public static function rgbToHsl(color:int):Array{
            var r:Number = color >> 16;
            var g:Number = (color ^ (r << 16)) >> 8;
            var b:Number = (color ^ (r << 16)) ^ (g << 8);
			
		    r /= 255, g /= 255, b /= 255;
		    var max:Number = Math.max(r, g, b);
		    var min:Number = Math.min(r, g, b);
		    var h:Number = (max + min) / 2;
		    var s:Number = h;
		    var l:Number = h;


		    if(max == min){
		        h = s = 0; // achromatic
		    }else{
		        var d:Number = max - min;
		        s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
		        switch(max){
		            case r: h = (g - b) / d + (g < b ? 6 : 0); break;
		            case g: h = (b - r) / d + 2; break;
		            case b: h = (r - g) / d + 4; break;
		        }
		        h /= 6;
		    }

		    return [h, s, l];
		}
	}
}
