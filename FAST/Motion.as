package {
	import com.fastframework.motion.MotionTween;

	import flash.display.DisplayObject;

	/**	 * @author colin */	final public class Motion extends MotionTween{
		private var base:DisplayObject;		public function Motion(mc:DisplayObject,obj:Object=null) {
			base = mc;			super(mc, obj);		}
		
		public function hideSprite():Motion{
			base.alpha=0;
			base.visible=false;
			return this;
		}	}}