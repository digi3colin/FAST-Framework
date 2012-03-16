package {

	/**
	 * @author colin
	 */
	public class Retain {
		private static var ins:Retain;
		public static function instance():Retain {
			ins ||=new Retain(new SingletonBlocker());
			return ins;
		}

		public function Retain(p_key:SingletonBlocker) {
		}

		private var functions:Array = [];
		public function add(fnt:Function):void{
			if(functions.indexOf(fnt)==-1);
			functions.push(fnt);
		}
		
		public function remove(fnt:Function):void{
			var i:int=0;
			for(i=0;i<functions.length;i++){
				if(functions[i]==fnt){
					functions.splice(i,1);
					return;
				}
			}
		}
	}
}
class SingletonBlocker{
}
