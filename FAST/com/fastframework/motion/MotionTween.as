package com.fastframework.motion {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.IFASTEventDispatcher;
	import com.fastframework.easing.Regular;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	public class MotionTween extends FASTEventDispatcher implements IFASTEventDispatcher{		private var mc:DisplayObject; 

		private var time:Number;		private var beginState:MotionTransform;
		private var targetState:MotionTransform;		private var deltaState:MotionTransform;
	
		private var dur:int              = 10;
		private var tweenDelay:int       = 0;		private var response:Boolean     = false;
		private var goFrame:String       = "";
		private var indTweenMethod:Array = [];		private var tweenMethod:Function;

		private var mcProxy : TweenControl;		private var colorDiff : Number=0;		private var _isTweening:Boolean;
		public function dealloc(...e):void{			mc.loaderInfo.removeEventListener(Event.UNLOAD, dealloc);			MotionTweenIterator.instance().removeTween(this);			MotionTweenIterator.instance().removeTweenControl(mc);			beginState = null;			targetState = null;			deltaState = null;			indTweenMethod = null;			tweenMethod = null;			mcProxy = null;			mc = null;		}		public function MotionTween(mc:DisplayObject,obj:Object=null) {			if(mc.loaderInfo!=null)mc.loaderInfo.addEventListener(Event.UNLOAD, dealloc);
			this.mc = mc;			beginState = new MotionTransform();			targetState= new MotionTransform();
			mcProxy = MotionTweenIterator.instance().getTweenControl(mc);
			setDefaultProps();
			indTweenMethod = new Array();			tweenMethod = Regular.easeInOut;			if(obj!=null)setTargetProps(obj);
		}
		public function hideSprite():MotionTween{			this.mc.alpha=0;			this.mc.visible=false;			return this;		}
		//tween method for different properties.
		public function indTweenMethodCode(prop:String,t:Number, b:Number, c:Number, d:Number):Number{
			return (typeof(indTweenMethod[prop])=='function')?indTweenMethod[prop](t,b,c,d):tweenMethod(t,b,c,d);
		}	
		private function setDeltaValues() : void {						deltaState = new MotionTransform();			deltaState.x=targetState.x  -beginState.x;
			deltaState.y=targetState.y  -beginState.y;
			deltaState.r=targetState.r  -beginState.r;
			deltaState.xs=targetState.xs-beginState.xs;
			deltaState.ys=targetState.ys-beginState.ys;			if(Boolean(colorDiff>>1&1))deltaState.c.alphaMultiplier = targetState.c.alphaMultiplier - beginState.c.alphaMultiplier;			if(Boolean(colorDiff>>2&1))deltaState.c.alphaOffset     = targetState.c.alphaOffset     - beginState.c.alphaOffset;			if(Boolean(colorDiff>>3&1))deltaState.c.redMultiplier   = targetState.c.redMultiplier   - beginState.c.redMultiplier;
			if(Boolean(colorDiff>>4&1))deltaState.c.redOffset       = targetState.c.redOffset       - beginState.c.redOffset;
			if(Boolean(colorDiff>>5&1))deltaState.c.greenMultiplier = targetState.c.greenMultiplier - beginState.c.greenMultiplier;
			if(Boolean(colorDiff>>6&1))deltaState.c.greenOffset     = targetState.c.greenOffset     - beginState.c.greenOffset;
			if(Boolean(colorDiff>>7&1))deltaState.c.blueMultiplier  = targetState.c.blueMultiplier  - beginState.c.blueMultiplier;
			if(Boolean(colorDiff>>8&1))deltaState.c.blueOffset      = targetState.c.blueOffset      - beginState.c.blueOffset;
		}
		public function tweenCode():void{
			if(beginState.x !=targetState.x)mc.x        = indTweenMethodCode('x' ,time ,beginState.x ,deltaState.x ,dur);
			if(beginState.y !=targetState.y)mc.y        = indTweenMethodCode('y' ,time ,beginState.y ,deltaState.y ,dur);
			if(beginState.r !=targetState.r)mc.rotation = indTweenMethodCode('r' ,time ,beginState.r ,deltaState.r ,dur);
			if(beginState.xs!=targetState.xs)mc.scaleX  = indTweenMethodCode('xs',time ,beginState.xs,deltaState.xs,dur);
			if(beginState.ys!=targetState.ys)mc.scaleY  = indTweenMethodCode('ys',time ,beginState.ys,deltaState.ys,dur);
			if(colorDiff>0){				//clone the target's current color transform.				var ncolor:ColorTransform = mc.transform.colorTransform;				if(Boolean(colorDiff>>1&1))ncolor.alphaMultiplier   = indTweenMethodCode('c', time, beginState.c.alphaMultiplier, deltaState.c.alphaMultiplier, dur);				if(Boolean(colorDiff>>2&1))ncolor.alphaOffset       = indTweenMethodCode('c', time, beginState.c.alphaOffset,     deltaState.c.alphaOffset,     dur);				if(Boolean(colorDiff>>3&1))ncolor.redMultiplier     = indTweenMethodCode('c', time, beginState.c.redMultiplier,   deltaState.c.redMultiplier,   dur);				if(Boolean(colorDiff>>4&1))ncolor.redOffset         = indTweenMethodCode('c', time, beginState.c.redOffset,       deltaState.c.redOffset,       dur);				if(Boolean(colorDiff>>5&1))ncolor.greenMultiplier   = indTweenMethodCode('c', time, beginState.c.greenMultiplier, deltaState.c.greenMultiplier, dur);				if(Boolean(colorDiff>>6&1))ncolor.greenOffset       = indTweenMethodCode('c', time, beginState.c.greenOffset,     deltaState.c.greenOffset,     dur);				if(Boolean(colorDiff>>7&1))ncolor.blueMultiplier    = indTweenMethodCode('c', time, beginState.c.blueMultiplier,  deltaState.c.blueMultiplier,  dur);				if(Boolean(colorDiff>>8&1))ncolor.blueOffset        = indTweenMethodCode('c', time, beginState.c.blueOffset,      deltaState.c.blueOffset,      dur);				mc.transform.colorTransform = ncolor;			}
			dispatchEvent(new Event(MotionTweenEvent.TWEENING));//{target:this,type:'onTween'});
			time++;
			if(time>dur){				killTween();
				onTweenEnd();
			}
		}

		public function isTweening():Boolean{
			return _isTweening;
		}
	
		public function startTween(obj:Object=null):MotionTween{//speed 1.54					if(obj!=null)setTargetProps(obj);			if(mcProxy.isTweening&&response==false)return this;
			//stop tween running			killTween();
			//create timeout for tweenDelay.
			clearTimeout(mcProxy.timeoutId);			mcProxy.timeoutId = setTimeout(initTween,tweenDelay);			return this;
		};
		
		private function initTween():void{			if((goFrame!="")&&(mc is MovieClip)){
				MovieClip(mc).gotoAndPlay(goFrame);
			}
			if(isNeedTween()){				onTweenStart();
				setBeginProps();
				setDeltaValues();
				addTween();
				_isTweening = true;
			}
		};
	
		public function killTween():void{
			clearTimeout(mcProxy.timeoutId);			removeTween();
			mc.visible = (mc.transform.colorTransform.alphaMultiplier == 0) || (mc.transform.colorTransform.alphaOffset == -255)||(mc.alpha==0)?false:true;
			_isTweening = false;
		};
	
		public function setBeginProps():void{
			time = 0;
			beginState.x  = mc.x;
			beginState.y  = mc.y;
			beginState.r  = mc.rotation;
			beginState.xs = mc.scaleX;
			beginState.ys = mc.scaleY;
			beginState.c  = mc.transform.colorTransform;
		};
	
		private function setDefaultProps():void{
			targetState.x  = mc.x;
			targetState.y  = mc.y;
			targetState.r  = mc.rotation;
			targetState.xs = mc.scaleX;
			targetState.ys = mc.scaleY;
			targetState.c  = mc.transform.colorTransform;
		};

		public function setTargetProps(obj:Object):void{			if(mcProxy.isTweening ==true){
				killTween();
			}
			if(obj['x'] !=null)targetState.x=obj['x'];
			if(obj['y'] !=null)targetState.y=obj['y'];
			if(obj['r'] !=null)targetState.r=obj['r'];
			if(obj['xs']!=null){				if(obj['xs']>1)obj['xs'] = obj['xs']/100;				targetState.xs=obj['xs'];
			}			if(obj['ys']!=null){				if(obj['ys']>1)obj['ys'] = obj['ys']/100;				targetState.ys=obj['ys'];			}			if(obj['a'] !=null){				if(obj['a']>1)obj['a'] = obj['a']/100;				targetState.c = new ColorTransform();				targetState.c.alphaMultiplier = obj['a'];			}
			if(obj['c'] !=null)targetState.c=obj['c'];			if(obj['dur']!=null)dur=obj['dur'];
			if(obj['tweenDelay']!=null)tweenDelay=obj['tweenDelay'];
			if(obj['tweenMethod']!=null)tweenMethod=obj['tweenMethod'];
			if(obj['response']!=null)response=obj['response'];
			if(obj['goFrame']!=null)goFrame=obj['goFrame'];
	
			if(obj['tmx']!=null)indTweenMethod['x'] = obj['tmx'];
			if(obj['tmy']!=null)indTweenMethod['y'] = obj['tmy'];
			if(obj['tmr']!=null)indTweenMethod['r'] = obj['tmr'];
			if(obj['tmxs']!=null)indTweenMethod['xs'] = obj['tmxs'];
			if(obj['tmys']!=null)indTweenMethod['ys'] = obj['tmys'];
			if(obj['tmc']!=null)indTweenMethod['c'] = obj['tmc'];
		};
	
		private function onTweenEnd():void{
			dispatchEvent(new MotionTweenEvent(MotionTweenEvent.END));
		}
	
		private function onTweenStart():void{
			dispatchEvent(new MotionTweenEvent(MotionTweenEvent.START));
		}
	
		private function isNeedTween():Boolean{			if(response==true)return true;
			if(isColorNeedTween()==true)return true;
			if(mc.x       !=targetState.x)return true;
			if(mc.y       !=targetState.y)return true;
			if(mc.alpha   !=targetState.c.alphaMultiplier)return true;
			if(mc.rotation!=targetState.r)return true;
			if(mc.scaleX  !=targetState.xs)return true;
			if(mc.scaleY  !=targetState.ys)return true;
			return false;
		};
	
		private function isColorNeedTween():Boolean{			var currColor:ColorTransform = mc.transform.colorTransform;			colorDiff =0;			if(currColor.color          !=targetState.c.color)          colorDiff+=1;			if(currColor.alphaMultiplier!=targetState.c.alphaMultiplier)colorDiff+=2;			if(currColor.alphaOffset    !=targetState.c.alphaOffset)    colorDiff+=4;			if(currColor.redMultiplier  !=targetState.c.redMultiplier)  colorDiff+=8;			if(currColor.redOffset      !=targetState.c.redOffset)      colorDiff+=16;			if(currColor.greenMultiplier!=targetState.c.greenMultiplier)colorDiff+=32;			if(currColor.greenOffset    !=targetState.c.greenOffset)    colorDiff+=64;			if(currColor.blueMultiplier !=targetState.c.blueMultiplier) colorDiff+=128;			if(currColor.blueOffset     !=targetState.c.blueOffset)     colorDiff+=256;			return (colorDiff>0);
		}
	
		private function addTween():void{
			MotionTweenIterator.instance().addTween(this);
			mc.visible = true;
		};
	
		private function removeTween():void{
			MotionTweenIterator.instance().removeTween(this);
		};
	}}