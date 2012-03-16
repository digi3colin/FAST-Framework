package com.fastframework.view {
	import com.fastframework.core.EventDispatcherUtils;
	import com.fastframework.core.FASTLog;
	import com.fastframework.utils.MovieClipTools;
	import com.fastframework.view.events.ButtonClipEvent;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;


	/**
	 * @author Colin
	 */
	final public class ButtonEvt extends EventDispatcher implements IButtonClip, IFASTEventDispatcher{
		private var _isHighlight:Boolean = false;
		private var hitArea: SimpleButton;
		private var overDelay : int=0;
		private var outDelay:int=0;
		private var overIID:uint;
		private var outIID:uint;
		private var elements : Array;
	
		private function autorelease(e:Event):void{
			hitArea.loaderInfo.removeEventListener(Event.UNLOAD, autorelease);
			hitArea.removeEventListener(MouseEvent.ROLL_OVER,	over);
			hitArea.removeEventListener(MouseEvent.ROLL_OUT,	out);
			hitArea.removeEventListener(MouseEvent.CLICK,		click);
			hitArea.removeEventListener(MouseEvent.MOUSE_DOWN,	down);
//			EventDispatcherUtils.instance().autorelease(this);
		}

		public function ButtonEvt(hitarea:SimpleButton){
			elements=[];
			this.hitArea = hitarea;
			hitArea.addEventListener(MouseEvent.ROLL_OVER,  over);
			hitArea.addEventListener(MouseEvent.ROLL_OUT,   out);
			hitArea.addEventListener(MouseEvent.CLICK,		click);
			hitArea.addEventListener(MouseEvent.MOUSE_DOWN, down);
			
			if(hitArea.loaderInfo!=null){
				hitArea.loaderInfo.addEventListener(Event.UNLOAD, autorelease);
			}
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

		private function clearIID():void{
			clearTimeout(overIID);
			clearTimeout(outIID);
		}

		private function out(...e):void{
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
		
		private function reset():void{
			dispatchEvent(new ButtonClipEvent(ButtonClipEvent.RESET     , isHighlight));
		}
		
		private function click(...e):void {
			FASTLog.instance().log("[ButtonEvt]:"+MovieClipTools.print(hitArea) + ":click/mouseup",FASTLog.LOG_LEVEL_DETAIL);
			dispatchEvent(new ButtonClipEvent(ButtonClipEvent.MOUSE_UP	, isHighlight));
			dispatchEvent(new ButtonClipEvent(ButtonClipEvent.CLICK		, isHighlight));
		}
	
		private function down(...e):void{
			FASTLog.instance().log("[ButtonEvt]:"+MovieClipTools.print(hitArea)+":mousedown",FASTLog.LOG_LEVEL_DETAIL);
			dispatchEvent(new ButtonClipEvent(ButtonClipEvent.MOUSE_DOWN, isHighlight));
		}

		public function get isHighlight():Boolean{
			return _isHighlight;
		}
		
		public function set isHighlight(value:Boolean):void{
			_isHighlight = value;
			reset();
		}
		
		public function getBase():SimpleButton{
			return hitArea;
		}

		public function select() : IButtonClip {
			isHighlight = true;
			reset();
			FASTLog.instance().log("[ButtonEvt]:"+MovieClipTools.print(hitArea)+":select",FASTLog.LOG_LEVEL_DETAIL);
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

		public function when(eventType : String, whichObject : Object, callFunction : Function) : * {
			EventDispatcherUtils.instance().when(this,eventType,whichObject,callFunction);
			return this;
		}
	}
}