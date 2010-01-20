package {
	import com.fastframework.error.SingletonError;

	import flash.display.DisplayObjectContainer;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * @author colin
 */
	final public class AS2 {
		private static var ins:AS2;
		public static function instance():AS2 {
			ins ||=new AS2(new SingletonBlocker());
			return ins;
		}

		private var _roots:Array;
		public function AS2(p_key:SingletonBlocker) {
			if(p_key==null)throw new SingletonError(this);
			_roots = [];
		}
		
		public function setRoot(sprite:DisplayObjectContainer,url:String="default"):void{
			_roots[url] = sprite;
		}
		
		public function getRoot(url:String="default"):DisplayObjectContainer{
			return _roots[url];
		}
		
		public function getURL(url:String,window:String=null):void{
			try {
				navigateToURL(new URLRequest(url),window);
    		} catch (e:Error) {
        		trace("AS2.getURL Error.");
    		}
		}
	}
}

internal class SingletonBlocker {}