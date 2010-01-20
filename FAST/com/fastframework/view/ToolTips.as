package com.fastframework.view{/**
 * @author colin
	 */
	import com.fastframework.motion.MotionTween;	import mx.transitions.easing.Regular;	import flash.display.Sprite;	import flash.text.TextField;	final public class ToolTips {
		static private var ins:ToolTips;		static public function instance():ToolTips{			if(ins==null)ins = new ToolTips();			return ins;		}			private var txf:TextField;		private var base : Sprite;		private var motion : MotionTween;
			public function ToolTips(){}		public function setClip(base:Sprite,txf:TextField):void{			this.base = base;			this.txf = txf;			base.alpha=1;			motion = new MotionTween(base ,{dur:5,tweenMethod:Regular.easeOut});		}		public function show(msg:String,x:Number= Number.NaN,y:Number= Number.NaN) : void {			x = (isNaN(x))?base.parent.mouseX:x;			y = (isNaN(y))?base.parent.mouseY:y;			txf.text = msg;			base.x = x;			base.y = y;			motion.startTween({a:100,x:x,y:y});		} 		public function hide():void{			motion.startTween({a:0,x:base.x,y:base.y});		}
	}}