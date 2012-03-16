﻿package com.fastframework.motion {
	import com.fastframework.easing.Regular;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.ColorTransform;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;


		private var time:Number;
		private var targetState:MotionTransform;
	
		private var dur:int              = 10;
		private var tweenDelay:int       = 0;
		private var goFrame:String       = "";
		private var indTweenMethod:Array = [];

		private var mcProxy : TweenControl;

			this.mc = mc;
			mcProxy = MotionTweenIterator.instance().getTweenControl(mc);
			setDefaultProps();
			indTweenMethod = new Array();
		}

		//tween method for different properties.
		public function indTweenMethodCode(prop:String,t:Number, b:Number, c:Number, d:Number):Number{
			return (typeof(indTweenMethod[prop])=='function')?indTweenMethod[prop](t,b,c,d):tweenMethod(t,b,c,d);
		}
		private function setDeltaValues() : void {			
			deltaState.y=targetState.y  -beginState.y;
			deltaState.r=targetState.r  -beginState.r;
			deltaState.xs=targetState.xs-beginState.xs;
			deltaState.ys=targetState.ys-beginState.ys;
			if(Boolean(colorDiff>>4&1))deltaState.c.redOffset       = targetState.c.redOffset       - beginState.c.redOffset;
			if(Boolean(colorDiff>>5&1))deltaState.c.greenMultiplier = targetState.c.greenMultiplier - beginState.c.greenMultiplier;
			if(Boolean(colorDiff>>6&1))deltaState.c.greenOffset     = targetState.c.greenOffset     - beginState.c.greenOffset;
			if(Boolean(colorDiff>>7&1))deltaState.c.blueMultiplier  = targetState.c.blueMultiplier  - beginState.c.blueMultiplier;
			if(Boolean(colorDiff>>8&1))deltaState.c.blueOffset      = targetState.c.blueOffset      - beginState.c.blueOffset;
		}

			if(beginState.x !=targetState.x)mc.x        = indTweenMethodCode('x' ,time ,beginState.x ,deltaState.x ,dur);
			if(beginState.y !=targetState.y)mc.y        = indTweenMethodCode('y' ,time ,beginState.y ,deltaState.y ,dur);
			if(beginState.r !=targetState.r)mc.rotation = indTweenMethodCode('r' ,time ,beginState.r ,deltaState.r ,dur);
			if(beginState.xs!=targetState.xs)mc.scaleX  = indTweenMethodCode('xs',time ,beginState.xs,deltaState.xs,dur);
			if(beginState.ys!=targetState.ys)mc.scaleY  = indTweenMethodCode('ys',time ,beginState.ys,deltaState.ys,dur);

			dispatchEvent(new Event(MotionTweenEvent.TWEENING));//{target:this,type:'onTween'});
			time++;
			if(time>dur){
				onTweenEnd();
			}
		}

		public function isTweening():Boolean{
			return _isTweening;
		}
	
		public function startTween(obj:Object=null):MotionTween{//speed 1.54		
			//stop tween running
			//create timeout for tweenDelay.
			clearTimeout(mcProxy.timeoutId);
		};
		
		private function initTween():void{
				MovieClip(mc).gotoAndPlay(goFrame);
			}
			if(isNeedTween()){
				setBeginProps();
				setDeltaValues();
				addTween();
				_isTweening = true;
			}
		};
	
		public function killTween():void{
			clearTimeout(mcProxy.timeoutId);
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

		public function setTargetProps(obj:Object):void{
				killTween();
			}
			if(obj['x'] !=null)targetState.x=obj['x'];
			if(obj['y'] !=null)targetState.y=obj['y'];
			if(obj['r'] !=null)targetState.r=obj['r'];
			if(obj['xs']!=null){
			}
			if(obj['c'] !=null)targetState.c=obj['c'];
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
	
		private function isNeedTween():Boolean{
			if(isColorNeedTween()==true)return true;
			if(mc.x       !=targetState.x)return true;
			if(mc.y       !=targetState.y)return true;
			if(mc.alpha   !=targetState.c.alphaMultiplier)return true;
			if(mc.rotation!=targetState.r)return true;
			if(mc.scaleX  !=targetState.xs)return true;
			if(mc.scaleY  !=targetState.ys)return true;
			return false;
		};
	
		private function isColorNeedTween():Boolean{
		}
	
		private function addTween():void{
			MotionTweenIterator.instance().addTween(this);
			mc.visible = true;
		};
	
		private function removeTween():void{
			MotionTweenIterator.instance().removeTween(this);
		};
	}