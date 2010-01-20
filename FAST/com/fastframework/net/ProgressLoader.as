package com.fastframework.net {
	import com.fastframework.event.EventDispatcherUtils;
	import com.fastframework.utils.Queue;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;

	/**
	 * @author colin
	 * provide the following service
	 * 1. loading Queue
	 * 2. error icon
	 * 3. preload icon
	 * 
	 * in default, error icon and preloader icon attach to _root
	 */
	final public class ProgressLoader extends EventDispatcher implements ILoader{
		private var base : ILoader;
	
		private var request : String;
		private var preloaderParent : DisplayObjectContainer; 
		private var preloader : DisplayObject;

		private var errorIconParent : DisplayObjectContainer;
		private var errorIcon : DisplayObject;
		
		private var queue:Queue;
	
		public function ProgressLoader(base:ILoader,queueThreadId:Number=-1){
			preloaderParent = AS2.instance().getRoot();
			errorIconParent = preloaderParent;
			queue = Queue.instance(queueThreadId);

			this.base = base;
			base.addEventListener(LoaderEvent.COMPLETE,forwardEvent);
			base.addEventListener(LoaderEvent.OPEN,    forwardEvent);
			base.addEventListener(LoaderEvent.PROGRESS,forwardEvent);
			base.addEventListener(LoaderEvent.READY,   forwardEvent);
			base.addEventListener(IOErrorEvent.IO_ERROR,forwardEvent);
			base.addEventListener(IOErrorEvent.IO_ERROR,onError);
			base.addEventListener(Event.COMPLETE,onLoadComplete);
		}
	
		public function load(request:String):void{
			this.request = request;
	
			if(queue==null){
				doLoad();
			}else{
				queue.addRequest(doLoad);
			}
		}
	
		public function getTargetContainer():Object{
			return base.getTargetContainer();
		}
	
		private function doLoad():void{
			if(preloader!=null)preloaderParent.addChild(preloader);
			base.load(request);
		}

		private function forwardEvent(evt:Event):void{
			dispatchEvent(evt);
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
			if(preloader.parent!=null)preloader.parent.removeChild(preloader);
			errorIconParent.addChild(errorIcon);
		}
		
		public function unload() : void {
			base.unload();
			if(preloader.parent!=null)preloader.parent.removeChild(preloader);
			if(errorIcon.parent!=null)errorIcon.parent.removeChild(errorIcon);
		}		public function when(eventType : String, whichObject : Object, callFunction : Function) : * {
			EventDispatcherUtils.when(this,eventType,whichObject,callFunction);
			return this;
		}
	}
}