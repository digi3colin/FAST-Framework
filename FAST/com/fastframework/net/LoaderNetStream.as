package com.fastframework.net {
	import com.fastframework.core.EventDispatcherUtils;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;


	/**
	 * @author colin
	 */
	public final class LoaderNetStream extends EventDispatcher implements ILoader {
		private var base:NetStream;
		private var nc:NetConnection;

		private function lazyLoading():void{
			if(base!=null)return;

			nc = new NetConnection();
			nc.connect(null);
			base = new NetStream(nc);
			base.addEventListener(Event.COMPLETE, 				forwardEvent,false,0,true);
			base.addEventListener(IOErrorEvent.IO_ERROR, 		forwardEvent,false,0,true);
			base.addEventListener(HTTPStatusEvent.HTTP_STATUS, 	forwardEvent,false,0,true);
			base.addEventListener(Event.OPEN, 					forwardEvent,false,0,true);
			base.addEventListener(ProgressEvent.PROGRESS, 		forwardEvent,false,0,true);
			base.addEventListener(Event.UNLOAD, 				forwardEvent,false,0,true);
		}

		private function forwardEvent(e:Event):void{
			dispatchEvent(e);
		}

		public function load(url : String) : Boolean {
			if(base==null)lazyLoading();

			base.play(url.split(".flv")[0]);
			return true;
		}

		public function sendAndLoad(url : String, postData : URLVariables, method : String) : Boolean {
			return this.load(url);
		}

		public function sendBinaryAndLoad(url : String, binary : ByteArray) : Boolean {
			return this.load(url);
		}

		public function unload() : void {
			if(base==null)return;
			base.close();
		}

		public function getBytesLoaded() : Number {
			return (base==null)?-1:base.bytesLoaded;
		}

		public function getBytesTotal() : Number {
			return (base==null)?-1:base.bytesTotal;
		}

		public function getContext() : * {
			if(base==null)lazyLoading();
			return base;
		}

		public function when(eventType : String, whichObject : Object, callFunction : Function) : * {
			EventDispatcherUtils.instance().when(this, eventType, whichObject, callFunction);
		}
	}
}
