package {
	import com.fastframework.core.EventDispatcherUtils;
	import com.fastframework.core.SingletonError;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;


	/**
	 * @author colin
	 */
	final public class JS extends EventDispatcher implements IFASTEventDispatcher{

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
		
		public function when(eventType : String, whichObject : Object, callFunction : Function) : * {
			EventDispatcherUtils.instance().when(this, eventType, whichObject, callFunction);
			return this;
		}
	}
}
