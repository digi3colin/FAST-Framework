package com.fastframework.core {
	import flash.events.ErrorEvent;
	import flash.events.Event;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	final public class FASTLog implements ILog{
		private static var ins:FASTLog;
		public static const LOG_LEVEL_NONE:int = -1;
		public static const LOG_LEVEL_ERROR:int = 0;
		public static const LOG_LEVEL_ACTION:int = 1;
		public static const LOG_LEVEL_DETAIL:int = 2;
		public var level:int=FASTLog.LOG_LEVEL_ACTION;
		
		private var logger:ILog;

		public static function instance():FASTLog {
			ins ||=new FASTLog();
			return ins;
		}



		public function FASTLog() {
			if(ins!=null){throw new SingletonError(this);}
			ins = this;
		}

		public function addGlobalError(loaderInfo:*) : void {
			try{
				loaderInfo['uncaughtErrorEvents']['addEventListener']("uncaughtError",errorLog);
				log('uncaughErrorCaptured');
			}catch(e:Error){
				
			}
		}

		private function errorLog(e:Event):void{
			if (e['error'] is Error) {
				log("ER:"+(e['error'] as Error).message);
			}else if (e['error'] is ErrorEvent){
				log("ER:"+(e['error'] as ErrorEvent).text);
			}else{
				log(e.toString());
			}
		}

		public function log(str:String,debugLevel:int=0):void{
			if(debugLevel>level)return;
			trace(str);
			if(logger==null)return;
			logger.log(str,debugLevel);
		}

		public function setLogger(logger:ILog):void{
			this.logger = logger;
		}
	}
}
