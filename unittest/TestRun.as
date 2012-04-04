package {
	import asunit.textui.TestRunner;
    public class TestRun extends TestRunner {

        public function TestRun() {
			try{
            	start(AllTests);
			}catch(e:Error){
				
			}
        }
    }
}
import asunit.framework.TestSuite;

import tests.core.ButtonClipTest;
import tests.core.FASTEventDispatcherTest;
import tests.core.NavigationTest;

class AllTests extends TestSuite{
    public function AllTests() {
        addTest(new NavigationTest());
		addTest(new FASTEventDispatcherTest());
		addTest(new ButtonClipTest());
    }
}