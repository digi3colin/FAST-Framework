package {
	import com.fastframework.utils.MovieClipTools;

	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author colin
	 */
	final public class Logger {
		private static var ins:Logger;
		public static function instance():Logger {
			ins ||=new Logger(new SingletonBlocker());
			return ins;
		}

		public function Logger(p_key:SingletonBlocker) {
		}
		private var txt:TextField;
		public function setView(mc:MovieClip):void{
			txt = MovieClipTools.findTextField(mc);
		}
		public function log(str:String):void{
			txt.appendText(str+'\n');
		}
	}
}
class SingletonBlocker{}