
/**
 * @author Colin
 */
package com.fastframework.view{
	import com.fastframework.core.IFASTEventDispatcher;
	public interface IButtonClip extends IFASTEventDispatcher{
		function addElement(element:IButtonElement):IButtonClip;
		function getElements():Array;
		function select(bln:Boolean=true):IButtonClip;

		function setMouseOverDelay(miniSecond:int):IButtonClip;
		function clearMouseOver():IButtonClip;
		function setMouseOutDelay(miniSecond:int):IButtonClip;
		function clearMouseOut():IButtonClip;
	}
}