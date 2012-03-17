package com.fastframework.facebook {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.IFASTEventDispatcher;
	import com.fastframework.core.SingletonError;
	import com.fastframework.utils.JS;
	import com.fastframework.utils.JSEvent;

	/**
	 * @author colin
	 */
	final public class FBConnect extends FASTEventDispatcher implements IFASTEventDispatcher{
		private static var ins:FBConnect;
		public static function instance():FBConnect {
			return ins || new FBConnect();
		}

		private const p:String = "FB.Connect.";
		public function FBConnect() {
			if(ins!=null)throw new SingletonError(this);ins = this;
			
			JS.instance().when(JSEvent.CALLBACK,this,jscall);
			JS.instance().call('onFlashReady');
		}
		
		private function jscall(e:JSEvent):void{
			if(e.msg.indexOf("FB")!=0)return;
			if(e.msg=='FB.userStatus::userConnected'){
				FBUser.instance().logon();
			}
			if(e.msg=='FB.userStatus::userNotConnected'){
				FBUser.instance().logout();
			}
			dispatchEvent(new FBConnectEvent(FBConnectEvent.CALLBACK, e.msg));
		}
		
		public function changeUser(callback:String=""):void
		{
			FBUser.instance()._loginInApplication = true;
			
			JS.instance().call(p+"logout(function(){FB.Connect.requireSession("+callback+");})");
		}
		
		public function get_loggedInUser():String{
			return JS.instance().call(p+'get_loggedInUser');
		}
		
		public function ifUserConnected (connectedArg:Object, notConnectedArg:Object):void
		{
			JS.instance().call(p+"ifUserConnected",connectedArg,notConnectedArg);
		}

		public function inviteConnectUsers ():void
		{
			JS.instance().call(p+"inviteConnectUsers");
		}

		public function logout (callback:String=""):void
		{
			
			JS.instance().call(p+"logout",callback);
		}
		public function logoutAndRedirect (redirectUrl:String):void
		{
			JS.instance().call(p+"logoutAndRedirect",redirectUrl);
		}
		public function pollLoginStatus (pollInterval:int, pollTries:int, callback:String=""):void
		{
			
			JS.instance().call(p+"pollLoginStatus",pollInterval,pollTries,callback);
		}
		public function requireSession (callback:String=""):void
		{
			FBUser.instance()._loginInApplication = true;
			
			JS.instance().call(p+"requireSession",callback);
		}
		public function showAddSectionButton (section:String, element:String):void
		{
			JS.instance().call(p+"showAddSectionButton",section,element);
		}
		public function showFeedDialog (template_bundle_id:int, template_data:Object, target_ids:Array, body_general:String, story_size:String, require_connect:String, callback:String=""):Boolean
		{
			
			return JS.instance().call(p+"showFeedDialog",template_bundle_id,template_data,target_ids,body_general,story_size,require_connect,callback);
		}
		public function showPermissionDialog (permission:String, callback:String=""):void
		{
			
			JS.instance().call(p+"showPermissionDialog",permission,callback);
		}
		public function showShareDialog (url:String, callback:String=""):void
		{
			
			JS.instance().call(p+"showShareDialog",url,callback);
		}
		public function streamPublish (user_message:String, attachment:Object, action_links:Object, target_id:String, user_message_prompt:String, callback:String="", auto_publish:Boolean=false):String
		{
			
			return JS.instance().call(p+"streamPublish",user_message,attachment,action_links,target_id,user_message_prompt,callback,auto_publish);
		}
	}
}
