package com.fastframework.net {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.FASTLog;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;


	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class FASTLoader extends FASTEventDispatcher implements ILoader {
		public static var sessionId:String='';
		private var isLoading:Boolean = false;
		private var loader : ILoader;
		private var behaviour: ILoadParser;
		private var url:String;

		public function FASTLoader(loader:ILoader,behaviour:ILoadParser=null) {
			this.behaviour = behaviour;
			
			this.loader = loader;
			this.loader.when(ProgressEvent.PROGRESS, 		this, onProgress);
			this.loader.when(Event.COMPLETE, 				this,onLoad);
			this.loader.when(IOErrorEvent.IO_ERROR, 		this,onIOError);
			this.loader.when(HTTPStatusEvent.HTTP_STATUS, 	this,onHttpStatus);
			this.loader.when(Event.UNLOAD, 					this,onUnload);

			this.loader.when(LoaderEvent.READY,	this,onReady);
			this.loader.when(Event.OPEN, 		this,onOpen);

		}

		private function onLoad(e:Event):void{
			isLoading = false;
			FASTLog.instance().log('loaded:'+this.url, FASTLog.LOG_LEVEL_ACTION);
			if(behaviour!=null)behaviour.onLoad(this.loader);
			forwardEvent(e);
		}

		private function onIOError(e:IOErrorEvent):void{
			isLoading = false;
			FASTLog.instance().log(e.text,FASTLog.LOG_LEVEL_ERROR);
			forwardEvent(e);
		}

		private function onHttpStatus(e:HTTPStatusEvent) : void {
			FASTLog.instance().log(e.toString(),FASTLog.LOG_LEVEL_DETAIL);
			forwardEvent(e);
		}

		private function onOpen(e:Event) : void {
			FASTLog.instance().log(e.toString(),FASTLog.LOG_LEVEL_DETAIL);
			forwardEvent(e);
		}

		private function onProgress(e:ProgressEvent):void{
			FASTLog.instance().log(e.toString(),FASTLog.LOG_LEVEL_DETAIL);
			forwardEvent(e);
		}

		private function onUnload(e:Event):void{
			FASTLog.instance().log(e.toString(),FASTLog.LOG_LEVEL_DETAIL);
			forwardEvent(e);
		}

		private function onReady(e:Event):void{
			FASTLog.instance().log(e.toString(),FASTLog.LOG_LEVEL_DETAIL);
			forwardEvent(e);
		}

		private function forwardEvent(e:Event):void{
			dispatchEvent(e);
		}

		private function urlWithSession(url:String):String{
			if(FASTLoader.sessionId=='')return url;

			if(url.indexOf('&sessionId=')==-1){
				url = url+ ((url.indexOf('?')==-1)?"?":"") + '&sessionId='+FASTLoader.sessionId;
			}
			return url;
		}

		public function sendAndLoad(url : String, postData : URLVariables, method : String) : Boolean {
			if(isLoading==true)return false;
			this.url = url;

			isLoading = this.loader.sendAndLoad(url=urlWithSession(url), postData, method);
			FASTLog.instance().log('sendAndLoad:'+url,FASTLog.LOG_LEVEL_ACTION);
			return isLoading;
		}

		public function sendBinaryAndLoad(url : String, binary : ByteArray) : Boolean {
			if(isLoading==true)return false;
			this.url = url;

			isLoading = this.loader.sendBinaryAndLoad(url=urlWithSession(url),binary);
			FASTLog.instance().log('sendBinaryAndLoad:'+url,FASTLog.LOG_LEVEL_ACTION);
			return isLoading;
		}

		public function load(url : String) : Boolean {
			if(isLoading==true)return false;
			this.url = url;

			isLoading = this.loader.load(url=urlWithSession(url));
			FASTLog.instance().log('load:'+url,FASTLog.LOG_LEVEL_ACTION);
			return isLoading;
		}

		public function unload() : void {
			this.loader.unload();
		}

		public function getBytesLoaded() : Number {
			return this.loader.getBytesLoaded();
		}

		public function getBytesTotal() : Number {
			return this.loader.getBytesTotal();
		}

		public function getContext() : * {
			if(behaviour!=null)return this.behaviour.getContext();
			return this.loader.getContext();
		}
	}
}
