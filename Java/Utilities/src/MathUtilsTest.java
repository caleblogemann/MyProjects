import static org.junit.Assert.*;

import org.junit.Assert;
import org.junit.Test;


public class MathUtilsTest {

	@Test
	public void testGCD() {
		Assert.assertEquals(1, MathUtils.GCD(7, 3));
		Assert.assertEquals(1, MathUtils.GCD(142, 63));
		Assert.assertEquals(9, MathUtils.GCD(63,9));
		Assert.assertEquals(3, MathUtils.GCD(432, 1023));
	}
	
	@Test
	public void testFactorial() {
		
	}

}
