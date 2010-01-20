package com.fastframework.view {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author colin
	 */
	final public class BitmapText {
		private var txf:TextField;
		private var bmp:Bitmap;
	
		public function BitmapText(base:Sprite,txf:TextField){
			this.txf = txf;

			bmp = new Bitmap(new BitmapData(txf.width, txf.height+20,true,0),PixelSnapping.ALWAYS,false);
			bmp.x = txf.x;
			bmp.y = txf.y;
			base.addChild(bmp);

			update();
			txf.visible = false;
		}
		
		public function update():void{
			bmp.bitmapData.fillRect(bmp.bitmapData.rect,0);
			bmp.bitmapData.draw(txf);
		}
		
		public function set text(str:String):void{
			txf.text = str;
			update();
		}
	}
}