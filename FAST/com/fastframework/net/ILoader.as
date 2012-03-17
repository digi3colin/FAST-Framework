
/**
 * @author colin
 */
package com.fastframework.net{
	import com.fastframework.core.IFASTEventDispatcher;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	public interface ILoader extends IFASTEventDispatcher{
		function load(url:String) : Boolean;
		function sendAndLoad(url : String, postData:URLVariables,method : String) : Boolean;
		function sendBinaryAndLoad(url:String, binary:ByteArray):Boolean;
		function unload() : void;
		function getBytesLoaded():Number;
		function getBytesTotal():Number;
		function getContext():*;
	}
}