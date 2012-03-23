package tests {
	import asunit.framework.TestCase;

	/**
	 * @author colin
	 */
	public class SampleTest extends TestCase {
        public function SampleTest(testMethod:String = null) {
            super(testMethod);
        }

        protected override function setUp():void {
        }

        protected override function tearDown():void {
        }

        public function testFail():void {
			assertTrue('This test must fail',true);
        }
	}
}