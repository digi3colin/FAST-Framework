package com.fastframework.view {
	import com.fastframework.motion.MotionTween;

	import flash.display.Sprite;
	import flash.text.TextField;
	final public class ProgressBar {
		private var view:Sprite;
		private var bar:Sprite;
		private var txt:TextField;
		private var isShow:Boolean =false;
		private var mt:MotionTween;
		
		public function ProgressBar(view:Sprite){
			this.view = view;
			txt = view['txt'];
			bar = view['bar'];
			mt = new MotionTween(view).hideSprite();
		}

		public function setProgress(progress:Number,msg:String=""):void{
			txt.text = msg+Math.floor(progress*100)+"%";
			bar.scaleX = progress;
	
			if(progress>=1 || progress<=0){
				hide();
				return;
			}
			show();
		}
	
		public function show():ProgressBar{
			if(isShow==true)return this;
			isShow = true;
			mt.startTween({a:100});
			return this;
		}
	
		public function hide():ProgressBar{
			if(isShow==false)return this;
			isShow = false;
			mt.startTween({a:0});
			return this;
		}
	}
}