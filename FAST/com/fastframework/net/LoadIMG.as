package com.fastframework.net {
	import com.fastframework.event.EventDispatcherUtils;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	/**	 * @author colin	 */	final public class LoadIMG implements IFASTEventDispatcher, ILoader{		private var base:Loader;		private var target:DisplayObjectContainer;
		private var bmp:Bitmap;			public function LoadIMG(target:DisplayObjectContainer){			this.target = target;
			bmp = new Bitmap();
			base = new Loader();			base.contentLoaderInfo.addEventListener(Event.COMPLETE, onStreamLoaded);		}		public function load(requestURL:String):void {
			if(bmp.parent==target)unload();			base.load(new URLRequest(requestURL));		}		public function getTargetContainer() : Object {			return base;		}
		public function unload() : void {
			target.removeChild(bmp);
			base.unload();		}

		public function willTrigger(type : String) : Boolean{
			return base.willTrigger(type);
		};

		public function addEventListener(type : String, listener:Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void {
			base.addEventListener(type, listener,useCapture,priority,useWeakReference);
			base.contentLoaderInfo.addEventListener(type,listener,useCapture,priority,useWeakReference);
			bmp.addEventListener(type, listener,useCapture,priority,useWeakReference);
		};

		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void {
			bmp.removeEventListener(type, listener,useCapture);
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
			var bm:BitmapData = new BitmapData(base.width,base.height);
			bm.draw(base);
			bmp.bitmapData = bm;
			bmp.smoothing = true;
			target.addChild(bmp);
			base.unload();
		}
	}
}