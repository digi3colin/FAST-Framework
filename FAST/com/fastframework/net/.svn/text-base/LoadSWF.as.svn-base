package com.fastframework.net {
	import com.fastframework.event.EventDispatcherUtils;

	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	/**
	 * @author colin
	 */
	final public class LoadSWF implements ILoader, IFASTEventDispatcher{
		private var base:Loader;
		private var target:DisplayObjectContainer;
	
		public function LoadSWF(target:DisplayObjectContainer){
			this.target = target;
			
			base = new Loader();
			base.contentLoaderInfo.addEventListener(Event.INIT, onStreamLoaded);
		}
		
		public function load(requestURL:String):void {
			if(base.parent==target)target.removeChild(base);
			
			base.unload();
			base.load(new URLRequest(requestURL),new LoaderContext(true));
		}
	
		public function getTargetContainer() : Object {
			return base;
		}
		public function unload() : void {
			base.unload();
		}
		public function willTrigger(type : String) : Boolean{
			return base.willTrigger(type);
		};

		public function addEventListener(type : String, listener:Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void {
			base.addEventListener(type, listener,useCapture,priority,useWeakReference);
			base.contentLoaderInfo.addEventListener(type,listener,useCapture,priority,useWeakReference);
		};

		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void {
			base.removeEventListener(type, listener,useCapture);
			base.contentLoaderInfo.removeEventListener(type,listener,useCapture);
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
		
		private function onStreamLoaded(e:Event):void{
			target.addChild(base);
		}
	}
}