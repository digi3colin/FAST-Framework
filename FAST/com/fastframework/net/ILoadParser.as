package com.fastframework.net {
	/**
	 * @author colin
	 */
	public interface ILoadParser {
		function onLoad(loader:ILoader):void;
		function getContext():*;
	}
}
