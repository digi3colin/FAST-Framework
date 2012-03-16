package com.fastframework.net {
	import com.fastframework.core.EventDispatcherUtils;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;


	/**
	 * @author colin
	 */
	public final class LoaderLoader extends EventDispatcher implements ILoader {
		private var base:Loader;
		private var loaderContext:LoaderContext;

		private function lazyLoading():void{
			if(base !=null)return;

			loaderContext = new LoaderContext(true,ApplicationDomain.currentDomain);
			base = new Loader();
			base.contentLoaderInfo.addEventListener(Event.COMPLETE, 			forwardEvent,false,0,true);
			base.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, 		forwardEvent,false,0,true);
			base.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS,forwardEvent,false,0,true);
			base.contentLoaderInfo.addEventListener(Event.OPEN, 				forwardEvent,false,0,true);
			base.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, 	forwardEvent,false,0,true);
			base.contentLoaderInfo.addEventListener(Event.UNLOAD, 				forwardEvent,false,0,true);
		}

		private function forwardEvent(e:Event):void{
			dispatchEvent(e);
		}

		public function load(url : String) : Boolean {
			if(base==null)lazyLoading();
			var req:URLRequest = new URLRequest(url);

			base.load(req, loaderContext);
			return true;
		}

		public function sendAndLoad(url : String, postData : URLVariables, method : String) : Boolean {
			if(base==null)lazyLoading();

			var req:URLRequest = new URLRequest(url);
			req.method = method;
			req.data = postData;

			base.load(req,loaderContext);
			return true;
		}

		public function sendBinaryAndLoad(url : String, binary : ByteArray) : Boolean {
			if(base==null)lazyLoading();
			
			var req:URLRequest = new URLRequest(url);
			req.contentType = 'application/octet-stream';
			req.method = URLRequestMethod.POST;
			req.data = binary;

			base.load(req);
			return true;
		}

		public function unload() : void {
			if(base==null)return;
			base.close();
		}

		public function getBytesLoaded() : Number {
			return (base==null)?-1:base.contentLoaderInfo.bytesLoaded;
		}

		public function getBytesTotal() : Number {
			return (base==null)?-1:base.contentLoaderInfo.bytesTotal;
		}

		public function when(eventType : String, whichObject : Object, callFunction : Function) : * {
			EventDispatcherUtils.instance().when(this, eventType, whichObject, callFunction);
			return this;
		}

		public function getContext() : * {
			if(base==null)lazyLoading();
			return base;
		}
	}
}
