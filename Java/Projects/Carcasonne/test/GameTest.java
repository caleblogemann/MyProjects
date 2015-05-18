import static org.junit.Assert.*;

import java.util.ArrayList;

import org.junit.Test;


public class GameTest {

	@Test
	public void test() {
		ArrayList<Tile> tiles = new ArrayList<Tile>(10);
		for(int i = 0; i < 10; i++){
			tiles.add(i,null);
		}
		System.out.println(tiles.get(1));
	}

}
