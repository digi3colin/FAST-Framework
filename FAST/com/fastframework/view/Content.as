package com.fastframework.view {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.IFASTEventDispatcher;
	import com.fastframework.core.utils.SystemUtils;
	import com.fastframework.motion.MotionTween;
	import com.fastframework.motion.MotionTweenEvent;
	import com.fastframework.navigation.Navigation;
	import com.fastframework.navigation.NavigationEvent;
	import com.fastframework.net.ILoader;
	import com.fastframework.net.LoaderEvent;
	import com.fastframework.net.LoaderFactory;
	import flash.display.Sprite;
	import flash.events.Event;




	/**
 * @author Colin
 */
	public class Content extends FASTEventDispatcher implements IFASTEventDispatcher{
		private var path:String;
		private var base:Sprite;
		private var prefix:String;
		private var currentNavKey:String;
		private var fadein:MotionTween;
		private var fadeout:MotionTween;
		private var targetName: String;
		private var extension : String;
		private var movieContainer:Sprite;

		private var ldr:ILoader;

		public function Content(mc:Sprite,parameter:String=null){
			path = SystemUtils.getMovieURLPath(mc)||"";
			this.base = mc;

			var para:Array;
			if(parameter==null){
				para = base.name.split('$');
			}else{
				para = parameter.split('$');
			}
			targetName	= para[1]||"";
			prefix		= para[2]||"";
			extension   = para[3]||"swf";

			mc.addChild(movieContainer = new Sprite());
			movieContainer.alpha=0.01;

			fadein  = new MotionTween(movieContainer,{a:100});
			fadeout = new MotionTween(movieContainer,{a:0});
			fadeout.when(MotionTweenEvent.END, this, onFadeOutAndLoad);

			Navigation.instance().when(NavigationEvent.CHANGE, this, onNavChange);
		}

		private function onNavChange(e:NavigationEvent):void{
			//if targetName is empty, load only 
			var navTargetIsEmpty:Boolean = (e.targetContainer==""||e.targetContainer==null);
	 		var criteria1:Boolean = (targetName==""&&navTargetIsEmpty);
	 		var criteria2:Boolean = (navTargetIsEmpty==false&&e.targetContainer==targetName);
			if(criteria1==false&&criteria2==false)return;

			currentNavKey = e.navKey;
			if(fadein.isTweening()==true)fadein.killTween();
			if(fadeout.isTweening()==true)return;
			fadeout.startTween();
		}

		private function onFadeOutAndLoad(e:MotionTweenEvent):void {
			loadAction();
		}

		private function loadAction():void{
			for(var i:int=0;i<movieContainer.numChildren;i++){
				movieContainer.removeChildAt(i);
			}

			var url:String = path+prefix+currentNavKey+"."+extension;

			ldr = LoaderFactory.instance().getSWFLoader(movieContainer);
			ldr.when(LoaderEvent.READY, this,onLoadContentAndFadeIn);
			ldr.load(url);
		}

		private function onLoadContentAndFadeIn(e:Event):void{
			if(Navigation.instance().getNavStackRequests()!=null){
				Navigation.instance().nextSection();
			}
			movieContainer.alpha=0.01;
			fadein.startTween();
		}
	}
}