package com.fastframework.view {
	import com.fastframework.net.ILoader;
	import com.fastframework.net.IProgressBar;
	import com.fastframework.utils.MovieClipTools;
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.text.TextField;


	/**
	 * @author colin
	 */
	final public class ProgressBar extends MovieClip implements IProgressBar{
		private var parentLoaderInfo:LoaderInfo;
		public var bar:Sprite;
		private var txt:TextField;
		private var motion:Motion;
		private var isShow:Boolean =false;
		private var loader:ILoader;
		
		private var isHeadless:Boolean = false;

		public function ProgressBar(){
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			txt = MovieClipTools.findTextField(this);
			if(txt==null)isHeadless = true;
			motion = new Motion(this).hideSprite();
		}

		private function onAddedToStage(...e):void{
			//find parent which have loader info;

			var _searchParent:DisplayObjectContainer = parent;
			while(_searchParent!=null){
				if(parent.loaderInfo!=null){
					parentLoaderInfo = _searchParent.loaderInfo;
					break;
				}
				_searchParent = _searchParent.parent;
			}
		}

		private function onRemoveFromStage(...e):void{
			motion.killTween();
		}

		public function setProgress(progress:Number,msg:String=""):void{
			show();
			var message:String = msg+Math.floor(progress*100)+"%";
			if(isHeadless==true){
				trace(message);
			}else{
				txt.text = message;
				bar.scaleX = progress;
			}
			if(progress>=1)hide();
		}

		public function show():ProgressBar{
			if(isShow==true)return this;
			isShow = true;
			motion.startTween({a:100});
			return this;
		}

		public function hide():ProgressBar{
			if(isShow==false)return this;
			isShow = false;
			motion.startTween({a:0});
			return this;
		}

		public function monitorLoader(loader:ILoader):void{
			this.loader = loader;
			loader.when(ProgressEvent.PROGRESS, this, onProgress);
		}

		private function onProgress(e:ProgressEvent):void{
			setProgress(e.bytesLoaded/e.bytesTotal,'loading:');
		}
	}
}
