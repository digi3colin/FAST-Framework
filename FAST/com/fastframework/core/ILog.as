package com.fastframework.core{
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public interface ILog {
		function addGlobalError(loaderInfoOrLoader:*) : void;
		function log(str:String,debugLevel:int=0):void;
		function setLogger(logger:ILog):void;
	}
}
