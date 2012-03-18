package {
	import com.fastframework.navigation.Navigation;
	import com.fastframework.navigation.NavigationEvent;
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