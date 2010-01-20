
/**
 * @author colin
 */

package com.fastframework.net {
	import com.fastframework.event.EventDispatcherUtils;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;

	final public class LoadCSS implements ILoader, IFASTEventDispatcher {
		private var baseLoader:URLLoader = new URLLoader();
		private var base:StyleSheet;

		public function LoadCSS(){
			base = new StyleSheet();
			baseLoader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            baseLoader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
		}
	
		public function getTargetContainer() : Object {
			return base;
		}

		public function willTrigger(type : String) : Boolean{
			return base.willTrigger(type);
		};

		public function addEventListener(event : String, handler:Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void {
			base.addEventListener(event,handler,useCapture,priority,useWeakReference);
		}

		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void {
			base.removeEventListener(type, listener, useCapture);
		}

		public function dispatchEvent(event : Event) : Boolean{
			return base.dispatchEvent(event);
		};
		
		public function hasEventListener(type : String) : Boolean{
			return base.hasEventListener(type);
		};

		public function when(eventType : String, whichObject : Object, callFunction : Function) : void {
			EventDispatcherUtils.when(this,eventType,whichObject,callFunction);
		}

		public function load(requestURL : String) : void {
			baseLoader.load(new URLRequest(requestURL));
		}

		public function unload() : void {
			base.clear();
		}

		private function errorHandler(e:IOErrorEvent):void{
			base.dispatchEvent(e);
		}
		
		private function loaderCompleteHandler(e:Event):void{
			base.parseCSS(baseLoader.data);
			base.dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}