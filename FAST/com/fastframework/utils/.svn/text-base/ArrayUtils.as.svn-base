package com.fastframework.utils {

	/**
	 * @author colin
	 */
	final public class ArrayUtils {
		public static function suffle(ary:Array) : void {
			var nLength:Number;
			var nRandom:Number;
			var temp:Array;
			var i:int;
			nLength = ary.length;
			for (i = 0; i < nLength; i++) {
				nRandom = Math.floor(Math.random()*nLength);
				temp = ary[i];
				ary[i] = ary[nRandom];
				ary[nRandom] = temp;
			}
		}
	}
}
