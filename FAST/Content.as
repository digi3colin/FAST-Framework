package {
	import com.fastframework.event.EventDispatcherUtils;
	import com.fastframework.motion.MotionTween;
	import com.fastframework.motion.MotionTweenEvent;
	import com.fastframework.navigation.Navigation;
	import com.fastframework.navigation.NavigationEvent;
	import com.fastframework.net.LoadSWF;
	import com.fastframework.net.LoaderEvent;
	import com.fastframework.utils.SystemUtils;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
 * @author Colin
 */
	public class Content extends EventDispatcher implements IEventDispatcher,IFASTEventDispatcher{
		private var path:String;
		private var base:MovieClip;
		private var loader:ILoader;
		private var prefix:String;
		private var currentNavKey:String;
		private var fadein:MotionTween;
		private var fadeout:MotionTween;
		private var targetName: String;
		private var extension : String;
		private var loadedMovie:DisplayObject;
	
		public function Content(mc:MovieClip){
			path = SystemUtils.getMovieURLPath(mc)||"";
			this.base = mc;

/*			loader = new ProgressLoader(new LoadSWF(base));
			loader.setPreloader(base);
			loader.setErrorIcon(base);*/
			
			loader = new LoadSWF(base);
			loader.when(LoaderEvent.READY, this,onLoadContentAndFadeIn);
			loadedMovie = DisplayObject(loader.getTargetContainer());

			var para:Array = base.name.split('$');
			targetName	= para[1]||"";
			prefix		= para[2]||"";
			extension   = para[3]||"swf";

			fadein  = new MotionTween(loadedMovie,{a:100});
			fadeout = new MotionTween(loadedMovie,{a:0}).when(MotionTweenEvent.END, this, onFadeOutAndLoad);
	
			var n:Navigation = Navigation.instance();
			n.when(NavigationEvent.CHANGE, this, onNavChange);
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
			loader.unload();
			loader.load(path+prefix+currentNavKey+"."+extension);	
		}
	
		private function onLoadContentAndFadeIn(e:Event):void{
			if(Navigation.instance().getNavStackRequests()!=null)Navigation.instance().nextSection();
			loadedMovie.alpha=0.01;
			fadein.startTween();
		}
	
		public function when(eventType : String, whichObject : Object, callFunction : Function) : * {
			EventDispatcherUtils.when(this,eventType,whichObject,callFunction);
			return this;
		}
	}
}