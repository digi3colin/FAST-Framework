package com.fastframework.utils {

	/**
	 * @author colin
	 */
	final public class Validate {
		public static function email(str:String):Boolean{
			return !(str.indexOf('@') == -1 || str.indexOf('.') == -1 || str.indexOf('@') == 0 || (str.indexOf('.') == str.length-1));
		}
		public static function password(str:String):Boolean{
			return !(str==""||str.indexOf(' ')==-1);
		}
		public static function isNotBlank(str:String):Boolean{
			return !(str=="");
		}
		public static function isNumber(str:String):Boolean{
			return !isNaN(Number(str));
		}
	}
}
