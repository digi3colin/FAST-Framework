package com.fastframework.net {
	import com.fastframework.core.SingletonError;
	import flash.display.DisplayObjectContainer;
	import flash.media.Video;
	import flash.net.URLLoaderDataFormat;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class LoaderFactory {
		private static var ins:LoaderFactory;
		public static function instance():LoaderFactory {
			return ins ||new LoaderFactory();

		}

		public function LoaderFactory() {
			if(ins!=null)throw new SingletonError(this);
			ins = this;
		}
		

		public function getBINLoader():ILoader{
			return new LoadingQueue(
			new FASTLoader(
				new LoaderURLLoader(URLLoaderDataFormat.BINARY),
				new ParseBIN()
			));
		}

		public function getCSSLoader():ILoader{
			return new LoadingQueue(
			new FASTLoader(
				new LoaderURLLoader(URLLoaderDataFormat.TEXT),
				new ParseCSS()
			));
		}

		public function getFLVLoader(vid:Video,autoPlay:Boolean=true,deblocking:Number=2,smooth:Boolean=true,buffer:Number=3):ILoader{
			return new LoadingQueue(
			new FASTLoader(
				new LoaderNetStream(),
				new ParseFLV(vid, autoPlay, deblocking, smooth, buffer)
			));
		}
		
		public function getIMGLoader(displayObjectContainer:DisplayObjectContainer):ILoader{
			return new LoadingQueue(
			new FASTLoader(
				new LoaderLoader(),
				new ParseIMG(displayObjectContainer)
			));
		}

		public function getSWFLoader(displayObjectContainer:DisplayObjectContainer):ILoader{
			return new LoadingQueue(
			new FASTLoader(
				new LoaderLoader(),
				new ParseSWF(displayObjectContainer)
			));
		}

		public function getVARLoader():ILoader{
			return new LoadingQueue(
			new FASTLoader(
				new LoaderURLLoader(URLLoaderDataFormat.VARIABLES),
				new ParseVAR()
			));
		}

		public function getXMLLoader():ILoader{
			return new LoadingQueue(
			new FASTLoader(
				new LoaderURLLoader(URLLoaderDataFormat.BINARY),
				new ParseZipXML()
			));
		}
		
		public function getUnCompressedXMLLoader():ILoader{
			return new LoadingQueue(
			new FASTLoader(
				new LoaderURLLoader(URLLoaderDataFormat.TEXT),
				new ParseXML()
			));
		}
	}
}