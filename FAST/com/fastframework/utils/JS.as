package com.fastframework.utils {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.IFASTEventDispatcher;
	import com.fastframework.core.SingletonError;

	import flash.external.ExternalInterface;


	/**
	 * @author colin
	 */
	final public class JS extends FASTEventDispatcher implements IFASTEventDispatcher{

		private static var ins:JS;
		public static function instance():JS {
			return ins || new JS();
		}

		public function JS() {
			if( ins != null ) throw new SingletonError();
			ins = this;

			ExternalInterface.addCallback("sendToActionScript", jscall);
		}

		public function call(functionName:String,...args:*):*{
			if(args['length']==0)return ExternalInterface.call(functionName);
			return ExternalInterface.call(functionName+"("+args+")");
		}
		
		private function jscall(str:String):void{
			dispatchEvent(new JSEvent(JSEvent.CALLBACK,str));
		}
	}
}
