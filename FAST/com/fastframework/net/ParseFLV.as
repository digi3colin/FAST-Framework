package com.fastframework.net {
	import flash.media.Video;
	import flash.net.NetStream;

	/**
	 * @author Colin
 */
	public class ParseFLV implements ILoadParser {
		private var vid : Video;
		private var buffer :Number=0;
		private var autoPlay:Boolean;

		public function ParseFLV(vid:Video,autoPlay:Boolean=true,deblocking:Number=2,smooth:Boolean=true,buffer:Number=3){
			this.vid = vid;
			this.vid.deblocking = deblocking;
			this.vid.smoothing = smooth;
			this.autoPlay = autoPlay;
			this.buffer = buffer;
		}

		public function onLoad(loader:ILoader):void{
			var ldr:NetStream = loader.getContext();
			if(autoPlay==false)ldr.pause();
			vid.attachNetStream(ldr);
			loader.dispatchEvent(new LoaderEvent(LoaderEvent.READY));
		}

		public function getContext() : * {
			return vid;
		}
	}
}