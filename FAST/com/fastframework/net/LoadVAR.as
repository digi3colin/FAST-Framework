package com.fastframework.net {
	import com.fastframework.event.EventDispatcherUtils;

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	/**
	 * @author Colin
	 */
	public class LoadVAR implements ILoader, IFASTEventDispatcher {
		private var _data:URLVariables;
		private var base:URLLoader;
	
		public function LoadVAR() {
			base = new URLLoader();
			base.dataFormat = URLLoaderDataFormat.VARIABLES;

			base.addEventListener(Event.COMPLETE, onLoaded);
		}
		
		public function load(requestURL : String) : void{
			base.load(new URLRequest(requestURL));
		}
	
		private function onLoaded(e:Event):void{
			_data = URLVariables(base.data);
		}

		public function getTargetContainer() : Object {
			return this;
		}
		
		public function sendAndLoad(url : String, request:URLVariables,method : String) : Boolean{
			var req:URLRequest = new URLRequest(url);
			req.method = method;
			req.data = request;
	
			return base.load(req);
		};
			
		public function getBytesLoaded() : Number{
			return base.bytesLoaded;
		};

		public function getBytesTotal() : Number{
			return base.bytesTotal;
		};
		
		public function get data():URLVariables{
			return _data;
		}

		public function unload() : void {
			base.close();
			base = null;
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