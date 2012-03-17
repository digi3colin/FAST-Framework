package com.fastframework.core{

	/**
	 * @author colin
	 */
	public interface ISave {
		function save():XML;
		function load(str:XML):Boolean;
	}
}
