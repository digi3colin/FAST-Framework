package {
	import com.fastframework.motion.MotionTween;

	import flash.display.Sprite;

	/**	 * @author colin */	final public class Motion extends MotionTween{
		private var base:Sprite;		public function Motion(mc:Sprite,obj:Object=null) {
			base = mc;			super(mc, obj);		}
		
		public function hideSprite():Motion{
			base.alpha=0;
			base.visible=false;
			return this;
		}	}}