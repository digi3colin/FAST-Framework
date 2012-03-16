package com.fastframework.core.navigation{
/**
 * @author colin
 */
	final public class NavStackRequest {
		public var navKey:String;
		public var targetContainer:String;
		public var isSuppress:Boolean;
		public var eventDispatcher:Object;
	
		public function NavStackRequest(navKey:String,targetContainer:String=null,isSuppress:Boolean=false,eventDispatcher:Object=null){
			this.navKey=navKey;
			this.targetContainer=targetContainer;
			this.isSuppress=isSuppress;
			this.eventDispatcher=eventDispatcher;
		}
	
		public function toString():String{
			return '[object NavStackRequest]:'+[navKey,targetContainer,isSuppress,eventDispatcher];
		}
	}
}