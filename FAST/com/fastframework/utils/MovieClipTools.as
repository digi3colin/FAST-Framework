package com.fastframework.utils {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.media.Video;
	import flash.text.TextField;

	/**
	 * @author Colin
	 */
	final public class MovieClipTools {
		public static function makeClickDisable(mc:InteractiveObject):void{
		};

		static public function print(mc:DisplayObject):String{
			var str:String=mc.name;
			
			while(mc.parent!=null){
				str = mc.parent.name+"/"+str;
				mc = mc.parent;
			}
			return str;
		}

		static public function notResize(mc:DisplayObject):void{
			var o:Point = mc.localToGlobal(new Point());
			var p:Point = mc.localToGlobal(new Point(1,1));
			var dx:Number =p.x-o.x;
			var dy:Number =p.y-o.y;
			mc.scaleX = mc.scaleX/dx;
			mc.scaleY = mc.scaleY/dy;
		}
		
		static public function captureTransform(mc:DisplayObject):Transform{
			return mc.transform;
		} 
		
		static public function killMovieClip(mc:DisplayObject):void{
			if(mc.parent!=null){
				mc.parent.removeChild(mc);
			}
		}
	
		static public function pixelAlign(mc:DisplayObject):void{
			if(mc.parent==null)return;
			var o:Point = mc.localToGlobal(new Point());
			o.x = Math.round(o.x);
			o.y = Math.round(o.y);
			var p:Point = mc.parent.globalToLocal(o);
			mc.x = p.x;
			mc.y = p.y;
		}

		public static function matchSize(mcToResize:DisplayObject,mcToMatch:DisplayObject,isCrop:Boolean=false):void{
			var ratioFlo:Number = mcToResize.width/mcToResize.height;
			var ratioFix:Number = mcToMatch.width/mcToMatch.height;
	
			if((ratioFlo>ratioFix&&isCrop==true)||(ratioFlo<ratioFix&&isCrop==false)){
				//match height
				//scale width with yscale
				mcToResize.height = mcToMatch.height;
				mcToResize.scaleX = mcToResize.scaleY;
			}else {
				//match width
				//scale height with xscale
				mcToResize.width  = mcToMatch.width;
				mcToResize.scaleY = mcToResize.scaleX;
			}
		}

		public static function alignCenter(floatMc:DisplayObject,fixMc:DisplayObject):void{
			if(fixMc.stage==null)return;
			if(floatMc.stage==null)return;

			//find the center of fixMc over the stage
			var fixBox:Rectangle = fixMc.getBounds(fixMc.stage);
			var cx:Number = fixBox.left+ (fixBox.width/2);
			var cy:Number = fixBox.top + (fixBox.height/2);

			var d:Point = floatMc.globalToLocal(new Point(cx,cy));

			floatMc.x += (d.x*floatMc.scaleX);
			floatMc.y += (d.y*floatMc.scaleY);
		};
/*	
		public static function alignStageXCenter(floatMc:DisplayObject):void{
			if(floatMc.stage==null)return;
			var fixMcCenterX:Number = floatMc.stage.stageWidth/2;
			floatMc.x = fixMcCenterX - floatMc.width + floatMc.width/2;
		}
	
		public static function alignStageYCenter(floatMc:DisplayObject):void{
			if(floatMc.stage==null)return;
			var fixMcCenterY:Number = floatMc.stage.stageHeight/2;
			floatMc.y = fixMcCenterY - floatMc.height + floatMc.height/2;
		}
*/
			// ==============
		// implement from http://www.adobe.com/devnet/flash/articles/adv_draw_methods.html
		// mc.drawRect() - by Ric Ewing (ric@formequalsfunction.com) - version 1.1 - 4.7.2002
		// 
		// x, y = top left corner of rect
		// w = width of rect
		// h = height of rect
		// cornerRadius = [optional] radius of rounding for corners (defaults to 0)
		// ==============
		public static function drawRect(mc:Sprite,x:Number, y:Number, w:Number, h:Number, cornerRadius:Number):void {
			// if the user has defined cornerRadius our task is a bit more complex. :)
			if (cornerRadius>0) {
				// init vars
				var theta:Number, angle:Number, cx:Number, cy:Number, px:Number, py:Number;
				// make sure that w + h are larger than 2*cornerRadius
				if (cornerRadius>Math.min(w, h)/2) {
					cornerRadius = Math.min(w, h)/2;
				}
				// theta = 45 degrees in radians
				theta = Math.PI/4;
				// draw top line
				mc.graphics.moveTo(x+cornerRadius, y);
				mc.graphics.lineTo(x+w-cornerRadius, y);
				//angle is currently 90 degrees
				angle = -Math.PI/2;
				// draw tr corner in two parts
				cx = x+w-cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
				cy = y+cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
				px = x+w-cornerRadius+(Math.cos(angle+theta)*cornerRadius);
				py = y+cornerRadius+(Math.sin(angle+theta)*cornerRadius);
				mc.graphics.curveTo(cx, cy, px, py);
				angle += theta;
				cx = x+w-cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
				cy = y+cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
				px = x+w-cornerRadius+(Math.cos(angle+theta)*cornerRadius);
				py = y+cornerRadius+(Math.sin(angle+theta)*cornerRadius);
				mc.graphics.curveTo(cx, cy, px, py);
				// draw right line
				mc.graphics.lineTo(x+w, y+h-cornerRadius);
				// draw br corner
				angle += theta;
				cx = x+w-cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
				cy = y+h-cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
				px = x+w-cornerRadius+(Math.cos(angle+theta)*cornerRadius);
				py = y+h-cornerRadius+(Math.sin(angle+theta)*cornerRadius);
				mc.graphics.curveTo(cx, cy, px, py);
				angle += theta;
				cx = x+w-cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
				cy = y+h-cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
				px = x+w-cornerRadius+(Math.cos(angle+theta)*cornerRadius);
				py = y+h-cornerRadius+(Math.sin(angle+theta)*cornerRadius);
				mc.graphics.curveTo(cx, cy, px, py);
				// draw bottom line
				mc.graphics.lineTo(x+cornerRadius, y+h);
				// draw bl corner
				angle += theta;
				cx = x+cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
				cy = y+h-cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
				px = x+cornerRadius+(Math.cos(angle+theta)*cornerRadius);
				py = y+h-cornerRadius+(Math.sin(angle+theta)*cornerRadius);
				mc.graphics.curveTo(cx, cy, px, py);
				angle += theta;
				cx = x+cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
				cy = y+h-cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
				px = x+cornerRadius+(Math.cos(angle+theta)*cornerRadius);
				py = y+h-cornerRadius+(Math.sin(angle+theta)*cornerRadius);
				mc.graphics.curveTo(cx, cy, px, py);
				// draw left line
				mc.graphics.lineTo(x, y+cornerRadius);
				// draw tl corner
				angle += theta;
				cx = x+cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
				cy = y+cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
				px = x+cornerRadius+(Math.cos(angle+theta)*cornerRadius);
				py = y+cornerRadius+(Math.sin(angle+theta)*cornerRadius);
				mc.graphics.curveTo(cx, cy, px, py);
				angle += theta;
				cx = x+cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
				cy = y+cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
				px = x+cornerRadius+(Math.cos(angle+theta)*cornerRadius);
				py = y+cornerRadius+(Math.sin(angle+theta)*cornerRadius);
				mc.graphics.curveTo(cx, cy, px, py);
			} else {
				// cornerRadius was not defined or = 0. This makes it easy.
				mc.graphics.moveTo(x, y);
				mc.graphics.lineTo(x+w, y);
				mc.graphics.lineTo(x+w, y+h);
				mc.graphics.lineTo(x, y+h);
				mc.graphics.lineTo(x, y);
			}
		};
		
		public static function findButton(mc:DisplayObjectContainer):SimpleButton{
			for(var i:int=0;i<mc.numChildren;i++){
				if(mc.getChildAt(i) is SimpleButton){
					return SimpleButton(mc.getChildAt(i));
				}
			}
			return null;
		}
		
		public static function findVideo(mc : DisplayObjectContainer) : Video {
			for(var i:int=0;i<mc.numChildren;i++){
				if(mc.getChildAt(i) is Video){
					return Video(mc.getChildAt(i));
				}
			}
			return null;
		}
		
		public static function findTextField(mc : DisplayObjectContainer) : TextField {
			for(var i:int=0;i<mc.numChildren;i++){
				if(mc.getChildAt(i) is TextField){
					return TextField(mc.getChildAt(i));
				}
			}
			return null;
		}
	}
}
