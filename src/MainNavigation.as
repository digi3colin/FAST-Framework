package {
	import com.fastframework.core.navigation.NavigationEvent;
	import com.fastframework.core.navigation.Navigation;
	import flash.display.Sprite;

	/**
	 * @author colin
	 */
	public class MainNavigation extends Sprite {
		public function MainNavigation() {
			Navigation.instance().when(NavigationEvent.CHANGE,this,onNavChange);
			Navigation.instance().changeSection("1_0");
		}
		private function onNavChange(e:NavigationEvent):void{
			trace(e.target);
			trace(e.navKey);
		}
	}
}