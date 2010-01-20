package com.fastframework.net {
	import com.fastframework.event.EventDispatcherUtils;

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	/**
	 * @author colin
	 */
	final public class LoadXML implements ILoader, IFASTEventDispatcher {
		private var base:URLLoader;
		private var xmlContent : XML;
	
		public function LoadXML(){
			base = new URLLoader();
			base.addEventListener(Event.COMPLETE,loaded);
		}
		
		private function loaded(e:Event):void{
			xmlContent = new XML(base.data);
		}
		
		public function getBase():XML{
			return xmlContent;
		}

		public function sendAndLoad(url : String, request:URLVariables,method : String) : Boolean{
			var req:URLRequest = new URLRequest(url);
			req.method = method;
			req.data = request;
			base.load(req);
			return true;
		};

		public function load(requestURL : String):void{
			base.load(new URLRequest(requestURL));
		}
	
		public function getTargetContainer() : Object {
			return xmlContent;
		}
		
		public function unload() : void {
		}

		public function willTrigger(type : String) : Boolean{
			return base.willTrigger(type);
		};

		public function addEventListener(type : String, listener:Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void {
			base.addEventListener(type, listener,useCapture,priority,useWeakReference);
		};

		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void {
			base.removeEventListener(type, listener,useCapture);
		};

		public function dispatchEvent(event : Event) : Boolean{
			return base.dispatchEvent(event);
		};
		
		public function hasEventListener(type : String) : Boolean{
			return base.hasEventListener(type);
		};
	
		public function when(eventType : String, whichObject : Object, callFunction : Function) : * {
			EventDispatcherUtils.when(this,eventType,whichObject,callFunction);
			return this;
		};
	}
}