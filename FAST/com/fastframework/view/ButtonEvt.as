package com.fastframework.view {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.FASTLog;
	import com.fastframework.core.utils.MovieClipTools;
	import com.fastframework.view.events.ButtonClipEvent;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;



	/**
	 * @author Colin
	 */
	final public class ButtonEvt extends FASTEventDispatcher implements IButtonClip{
		private var isHighlight:Boolean = false;
		private var overDelay : int=0;
		private var outDelay:int=0;
		private var overIID:uint;
		private var outIID:uint;
		private var elements : Array;
		
		private var hitarea:SimpleButton;

		public function ButtonEvt(hitarea:SimpleButton){
			elements=[];
			this.hitarea = hitarea;
			hitarea.addEventListener(MouseEvent.ROLL_OVER,  over,	false,0,true);
			hitarea.addEventListener(MouseEvent.ROLL_OUT,   out,	false,0,true);
			hitarea.addEventListener(MouseEvent.CLICK,		click,	false,0,true);
			hitarea.addEventListener(MouseEvent.MOUSE_DOWN, down,	false,0,true);
		}

		private function clearIID():void{
			clearTimeout(overIID);
			clearTimeout(outIID);
		}

		private function over(e:MouseEvent):void{
			clearIID();
			if(overDelay==0){
				doOver();
			}else{
				overIID = setTimeout(doOver,overDelay);
			}
		}
	
		private function doOver():void{
			clearIID();
			dispatchEvent(new ButtonClipEvent(ButtonClipEvent.MOUSE_OVER, isHighlight));
			dispatchEvent(new ButtonClipEvent(ButtonClipEvent.ROLL_OVER , isHighlight));
		}

		private function out(e:MouseEvent):void{
			clearIID();
			if(outDelay==0){
				doOut();
			}else{
				outIID = setTimeout(doOut,outDelay);
			}
		}
		
		private function doOut():void{
			dispatchEvent(new ButtonClipEvent(ButtonClipEvent.MOUSE_OUT , isHighlight));
			dispatchEvent(new ButtonClipEvent(ButtonClipEvent.ROLL_OUT  , isHighlight));
		}

		private function click(e:MouseEvent):void {
			FASTLog.instance().log("[ButtonEvt]:"+MovieClipTools.print(SimpleButton(e.target)) + ":click/mouseup",	FASTLog.LOG_LEVEL_DETAIL);
			dispatchEvent(new ButtonClipEvent(ButtonClipEvent.MOUSE_UP	, isHighlight));
			dispatchEvent(new ButtonClipEvent(ButtonClipEvent.CLICK		, isHighlight));
		}
	
		private function down(e:MouseEvent):void{
			FASTLog.instance().log("[ButtonEvt]:"+MovieClipTools.print(SimpleButton(e.target))+":mousedown",		FASTLog.LOG_LEVEL_DETAIL);
			dispatchEvent(new ButtonClipEvent(ButtonClipEvent.MOUSE_DOWN, isHighlight));
		}
		
		private function reset():void{
			dispatchEvent(new ButtonClipEvent(ButtonClipEvent.RESET     , isHighlight));
		}

		public function addElement(element:IButtonElement):IButtonClip{
			elements.push(element);
			this.when(ButtonClipEvent.MOUSE_OVER , element, element.buttonOver);
			this.when(ButtonClipEvent.MOUSE_OUT  , element, element.buttonOut);
			this.when(ButtonClipEvent.MOUSE_DOWN , element, element.buttonDown);
			this.when(ButtonClipEvent.RESET      , element, element.buttonReset);

			//immediate reset the element's status.
			element.buttonReset(new ButtonClipEvent(ButtonClipEvent.RESET,isHighlight));
			return this;
		}

		public function getElements():Array{
			return elements;
		}
	
		public function select(bln:Boolean = true) : IButtonClip {
			isHighlight = bln;
			reset();
			FASTLog.instance().log("[ButtonEvt]:"+MovieClipTools.print(SimpleButton(hitarea))+":select:"+bln,FASTLog.LOG_LEVEL_DETAIL);
			dispatchEvent(new ButtonClipEvent(ButtonClipEvent.SELECT, isHighlight));
			return this;
		}

		public function setMouseOverDelay(miniSecond : int) : IButtonClip {
			overDelay = miniSecond;
			return this;
		}
		
		public function setMouseOutDelay(miniSecond : int) : IButtonClip {
			outDelay = miniSecond;
			return this;
		}
	
		public function clearMouseOver() : IButtonClip {
			clearTimeout(overIID);
			return this;
		}
	
		public function clearMouseOut() : IButtonClip {
			clearTimeout(outIID);
			return this;
		}
	}
}