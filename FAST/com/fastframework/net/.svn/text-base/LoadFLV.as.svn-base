package com.fastframework.net {
	import com.fastframework.event.EventDispatcherUtils;

	import flash.events.Event;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;

	/**
	 * @author Colin
 */
	public class LoadFLV implements ILoader , IFASTEventDispatcher {
		private var vid : Video;
		private var vid_nc : NetConnection;
		private var base : NetStream;
		private var buffer :Number=0;
		private var autoPlay:Boolean;
	
		public function LoadFLV(vid:Video,autoPlay:Boolean=true,deblocking:Number=2,smooth:Boolean=true,buffer:Number=3){
			this.vid = vid;
			this.vid.deblocking = deblocking;
			this.vid.smoothing = smooth;
			this.autoPlay = autoPlay;
			this.buffer = buffer;
	
			vid_nc = new NetConnection();
			vid_nc.connect(null);
			base = new NetStream(vid_nc);
			base.bufferTime = buffer;
			vid.attachNetStream(base);
		}
	
		public function load(requestURL:String):void{
			unload();
			base.play(requestURL.split(".flv")[0]);

			if(autoPlay==false)base.pause();
		}
	
		public function getTargetContainer() : Object {
			return vid;
		}

		public function unload() : void {
			vid_nc.close();
			base.close();
		}

		public function willTrigger(type : String) : Boolean{
			return base.willTrigger(type);
		};

		public function addEventListener(type : String, listener:Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void {
			base.addEventListener(type,listener,useCapture,priority,useWeakReference);
		};

		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void {
			base.removeEventListener(type, listener, useCapture);
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
		
		public function getNetStream():NetStream{
			return base;
		}
	}
}