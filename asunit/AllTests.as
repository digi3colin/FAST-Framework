package {
	import asunit.framework.TestSuite;

	import tests.ArrayIteratorTest;
	/**
	 * @author colin
	 */
	public class AllTests extends TestSuite{
        public function AllTests() {
            addTest(new ArrayIteratorTest());
        }
	}
}
