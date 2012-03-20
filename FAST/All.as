package {
	import com.fastframework.core.EventDispatcherUtils;
	import com.fastframework.core.FASTLog;
	import com.fastframework.core.IFASTEventDispatcher;
	import com.fastframework.core.ISave;
	import com.fastframework.core.Queue;
	import com.fastframework.core.SingletonError;
	import com.fastframework.core.utils.CSSColor;
	import com.fastframework.core.utils.Conversion;
	import com.fastframework.core.utils.MovieClipTools;
	import com.fastframework.core.utils.StringUtils;
	import com.fastframework.core.utils.SystemUtils;
	import com.fastframework.easing.Back;
	import com.fastframework.easing.Bounce;
	import com.fastframework.easing.Elastic;
	import com.fastframework.easing.None;
	import com.fastframework.easing.Regular;
	import com.fastframework.easing.Strong;
	import com.fastframework.javascript.JS;
	import com.fastframework.javascript.JSEvent;
	import com.fastframework.javascript.facebook.FBConnect;
	import com.fastframework.javascript.facebook.FBConnectEvent;
	import com.fastframework.javascript.facebook.FBFeedStatus;
	import com.fastframework.javascript.facebook.FBUser;
	import com.fastframework.locale.Language;
	import com.fastframework.motion.MotionTween;
	import com.fastframework.navigation.Navigation;
	import com.fastframework.net.ILoader;
	import com.fastframework.net.LoaderEvent;
	import com.fastframework.net.ParseCSS;
	import com.fastframework.net.ParseFLV;
	import com.fastframework.net.ParseIMG;
	import com.fastframework.net.ParseSWF;
	import com.fastframework.net.ParseVAR;
	import com.fastframework.net.ProgressLoader;
	import com.fastframework.utils.AS2;
	import com.fastframework.utils.ArrayUtils;
	import com.fastframework.utils.Validate;
	import com.fastframework.view.BitmapText;
	import com.fastframework.view.ButtonClip;
	import com.fastframework.view.ButtonEvt;
	import com.fastframework.view.ButtonIcon;
	import com.fastframework.view.Content;
	import com.fastframework.view.FASTRadioButton;
	import com.fastframework.view.IButtonClip;
	import com.fastframework.view.IButtonElement;
	import com.fastframework.view.NavBtn;
	import com.fastframework.view.NavButton;
	import com.fastframework.view.SmartTextField;
	import com.fastframework.view.ToolTips;
	import com.fastframework.view.events.ButtonClipEvent;



	/**
	 * @author colin
	 */
	public class All {
		public function All(){
		AS2;
			ButtonClip;
			ButtonIcon;
			Content;
			FASTRadioButton;
			JS;
			JSEvent;

			NavBtn;
			SmartTextField;
			IButtonClip;
			IButtonElement;
			IFASTEventDispatcher;
			ILoader;
			ISave;

			FASTLog;
			SingletonError;
			
			EventDispatcherUtils;
			FBConnect;
			FBConnectEvent;
			FBFeedStatus;
			FBUser;
			
			Language;
			
			MotionTween;
			Navigation;
			LoaderEvent;
			ParseCSS;
			ParseFLV;
			ParseIMG;
			ParseSWF;
			ParseVAR;

			ProgressLoader;

			ArrayUtils;
			Conversion;
			CSSColor;
			MovieClipTools;
			Queue;
			StringUtils;
			SystemUtils;
			Validate;
			BitmapText;
			ButtonEvt;
			NavButton;
			ToolTips;
			ButtonClipEvent;
			Back;
			Bounce;
			Elastic;
			None;
			Regular;
			Strong;
		}
	}
}
