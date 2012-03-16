package com.fastframework.motion {
	import com.fastframework.core.SingletonError;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;


	/**
	 * @author colin
	 */
	final internal class MotionTweenIterator{
		private static var ins:MotionTweenIterator;
		public static function instance():MotionTweenIterator {
			return ins || new MotionTweenIterator();
		}

		public var tweenArray:Array;
		private var dict:Dictionary;
		private var timeServer : Sprite;

		public function MotionTweenIterator() {
			if(ins!=null)throw new SingletonError(this);
			ins = this;

			tweenArray = new Array();//:{MotionTween};
			dict = new Dictionary(true);
	
			timeServer = new Sprite();
			timeServer.addEventListener(Event.ENTER_FRAME, loop, false,0,true);
		}
	
		private function loop(e:Event) : void {
			for(var i:Number=0;i<tweenArray.length;i++){
				MotionTween(tweenArray[i]).tweenCode();
			}
		}

		public function removeTweenControl(m:DisplayObject):void{
			delete dict[m];
		}

		public function getTweenControl(m:DisplayObject):TweenControl{
			dict[m] ||= new TweenControl();
			return dict[m];
		}

		public function addTween(m:MotionTween):void{
			if(tweenArray.indexOf(m)!=-1)return;
			tweenArray.push(m);
		}

		public function removeTween(m:MotionTween):void{
			for(var i:int=0;i<tweenArray.length;i++){
				if(tweenArray[i]===m){
					tweenArray.splice(i, 1);
					i--;
				}
			}
		}
	}
}