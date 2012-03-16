package com.fastframework.net {
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.Event;


	/**
	 * @author colin
	 */
	final public class ParseSWF implements ILoadParser{
		private var view:DisplayObjectContainer;
		private var frameCount:int=0;
		private var loader:ILoader;

		public function ParseSWF(target:DisplayObjectContainer){
			this.view = target;
		}

		private function onFirstFrameRun(e:Event):void{
			frameCount++;
			//hack, assume actionscript is loaded when frame 2 running.
			//call loader to dispatch event. 
			if(frameCount>2){
				view.removeEventListener(Event.ENTER_FRAME, onFirstFrameRun);
				loader.dispatchEvent(new LoaderEvent(LoaderEvent.READY));
				loader = null;
			}
		}

		public function onLoad(loader:ILoader):void{
			this.loader = loader;
			view.addChild(Loader(loader.getContext()));
			frameCount=0;
			view.removeEventListener(Event.ENTER_FRAME, onFirstFrameRun);
			view.addEventListener(Event.ENTER_FRAME, onFirstFrameRun);
		}

		public function getContext() : * {
			return view;
		}
	}
}