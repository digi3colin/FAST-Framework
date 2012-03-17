package com.fastframework.net {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.utils.AS2;
	import com.fastframework.utils.Queue;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;


	/**
	 * @author colin
	 * provide the following service
	 * 1. loading Queue
	 * 2. error icon
	 * 3. preload icon
	 * 
	 * in default, error icon and preloader icon attach to _root
	 */
	final public class ProgressLoader extends FASTEventDispatcher implements ILoader{
		private var loader : ILoader;

		private var preloaderParent : DisplayObjectContainer; 
		private var preloader : DisplayObject;

		private var errorIconParent : DisplayObjectContainer;
		private var errorIcon : DisplayObject;
		
		private var queue:Queue;

		public function ProgressLoader(loader:ILoader,queueThreadId:Number=-1,preloader:DisplayObject=null, preloaderParent:DisplayObjectContainer=null, errorIcon:DisplayObject=null, errorIconParent:DisplayObjectContainer=null){

			this.preloaderParent = (preloaderParent is DisplayObjectContainer)?preloaderParent:AS2.instance().getRoot();
			this.preloader = (preloader is DisplayObject)?preloader:null;
			this.errorIconParent = (errorIconParent is DisplayObjectContainer)?errorIconParent:AS2.instance().getRoot();
			this.errorIcon = (errorIcon is DisplayObject)?errorIcon:null;

			queue = Queue.instance(queueThreadId);

			this.loader = loader;
			this.loader.when(Event.COMPLETE, 				this, forwardEvent);
			this.loader.when(IOErrorEvent.IO_ERROR, 		this, forwardEvent);
			this.loader.when(HTTPStatusEvent.HTTP_STATUS, 	this, forwardEvent);
			this.loader.when(Event.OPEN, 					this, forwardEvent);
			this.loader.when(ProgressEvent.PROGRESS, 		this, forwardEvent);
			this.loader.when(Event.UNLOAD, 					this, forwardEvent);

			this.loader.when(IOErrorEvent.IO_ERROR,			this,onError);
			this.loader.when(Event.COMPLETE,				this,onLoadComplete);
		}

		public function getContext():*{
			return loader;
		}

		private function forwardEvent(e:Event):void{
			dispatchEvent(e);
		}

		public function setPreloader(preloaderParent:DisplayObjectContainer,preloader:DisplayObject=null):void{
			this.preloaderParent = preloaderParent;
			if(preloader!=null)this.preloader = preloader;
		}
		
		public function setErrorIcon(errorIconParent:DisplayObjectContainer,errorIcon:DisplayObject=null):void{
			this.errorIconParent = errorIconParent;
			if(errorIcon!=null)this.errorIcon = errorIcon;
		}

		private function onLoadComplete(e:Event) : void {
			queue.next();
			if(preloader==null)return;
			if(errorIcon==null)return;
			if(preloader.parent!=null)preloader.parent.removeChild(preloader);
			if(errorIcon.parent!=null)errorIcon.parent.removeChild(errorIcon);
		}

		private function onError(e:Event):void{
			queue.next();
			if(preloader==null)return;
			if(errorIcon==null)return;
			if(preloader.parent!=null)preloader.parent.removeChild(preloader);
			errorIconParent.addChild(errorIcon);
		}

		public function unload() : void {
			loader.unload();
			if(preloader!=null && preloader.parent!=null)preloader.parent.removeChild(preloader);
			if(errorIcon!=null && errorIcon.parent!=null)errorIcon.parent.removeChild(errorIcon);
		}

		public function load(request:String):Boolean{
			queue.addCommand(new ProgressLoaderLoadCommand(this,preloaderParent,preloader,request));
			return true;
		}
		
		public function sendAndLoad(url : String, postData : URLVariables, method : String) : Boolean {
			queue.addCommand(
				new ProgressLoaderSendAndLoadCommand(this,preloaderParent,preloader,url,postData,method));
			return true;
		}
		
		public function sendBinaryAndLoad(url : String, binary : ByteArray) : Boolean {
			queue.addCommand(
				new ProgressLoaderSendBinaryAndLoadCommand(this,preloaderParent,preloader,url,binary));
			return true;
		}

		public function getBytesLoaded() : Number {
			return loader.getBytesLoaded();
		}

		public function getBytesTotal() : Number {
			return loader.getBytesTotal();
		}
	}
}
import com.fastframework.net.ILoader;
import com.fastframework.net.IProgressBar;
import com.fastframework.net.ProgressLoader;
import com.fastframework.utils.ICommand;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.net.URLVariables;
import flash.utils.ByteArray;


class ProgressLoaderLoadCommand implements ICommand {
	private var base:ProgressLoader;
	private var url:String;
	private var preloader:DisplayObject;
	private var preloaderParent:DisplayObjectContainer;

	public function ProgressLoaderLoadCommand(loader:ProgressLoader,preloaderParent:DisplayObjectContainer,preloader:DisplayObject,url:String){
		this.base = loader;
		this.url = url;
		this.preloader = preloader;
		this.preloaderParent = preloaderParent;
	}

	public function execute() : void {
/*		if(preloader!=null && preloaderParent!=null){
			preloaderParent.addChild(preloader);
			IProgressBar(preloader).monitorLoader(base);
		}*/
		ILoader(base.getContext()).load(url);
	}
}

class ProgressLoaderSendAndLoadCommand implements ICommand {
	private var base:ProgressLoader;
	private var url:String;
	private var postData:URLVariables;
	private var method:String;
	private var preloader:DisplayObject;
	private var preloaderParent:DisplayObjectContainer;

	public function ProgressLoaderSendAndLoadCommand(loader:ProgressLoader,preloaderParent:DisplayObjectContainer,preloader:DisplayObject,url:String,postData:URLVariables,method:String){
		this.base = loader;
		this.preloaderParent = preloaderParent;
		this.preloader = preloader;
		this.url = url;
		this.postData = postData;
		this.method = method;
	}

	public function execute() : void {
		if(preloader!=null && preloaderParent!=null){
			preloaderParent.addChild(preloader);
			IProgressBar(preloader).monitorLoader(base);
		}
		ILoader(base.getContext()).sendAndLoad(url, postData, method);
	}
}

class ProgressLoaderSendBinaryAndLoadCommand implements ICommand {
	private var base:ProgressLoader;
	private var url:String;
	private var binary:ByteArray;
	private var preloader:DisplayObject;
	private var preloaderParent:DisplayObjectContainer;

	public function ProgressLoaderSendBinaryAndLoadCommand(loader:ProgressLoader,preloaderParent:DisplayObjectContainer,preloader:DisplayObject,url : String, binary : ByteArray){
		this.base = loader;
		this.preloaderParent = preloaderParent;
		this.preloader = preloader;
		this.url = url;
		this.binary = binary;
	}

	public function execute() : void {
		if(preloader!=null && preloaderParent!=null){
			preloaderParent.addChild(preloader);
			IProgressBar(preloader).monitorLoader(base);
		}
		ILoader(base.getContext()).sendBinaryAndLoad(url, binary);
	}
}