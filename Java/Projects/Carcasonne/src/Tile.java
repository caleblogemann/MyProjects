import java.util.ArrayList;
import java.util.List;
import java.util.Random;
public class Tile {
    public static final int GRASS = 0;
    public static final int ROAD  = 1;
    public static final int CITY  = 2;
    public static final int NUM_SIDE_OPTIONS = 3;
    public static final int NUM_SIDES = 4;

    // list to store what each side of the tile is
    private List<Integer> sides;

    // list of who owns each quadrant
    // null if nobody or grass quadrant
    private List<Player> owners;

    // index of sides representing top
    // proceed clockwise around tile
    private int orientation;

    // random number generator for generating new random tiles
    private static Random random = new Random();

    /**
     * @param northSide
     * @param eastSide
     * @param southSide
     * @param westSide
     * create a Tile object with these given sides
     */
    public Tile(int northSide, int eastSide, int southSide, int westSide){
        sides = new ArrayList<Integer>();
        sides.add(northSide);
        sides.add(eastSide);
        sides.add(southSide);
        sides.add(westSide);

        // set initial rotation to zero
        orientation = 0;
        // instantiate array of owners to be null;
        createEmptyOwnersArray();
    }

    /**
     * @return randomly generated tile object
     */
    public static Tile getRandomTile(){
        int n = random.nextInt(NUM_SIDE_OPTIONS);
        int e = random.nextInt(NUM_SIDE_OPTIONS);
        int s = random.nextInt(NUM_SIDE_OPTIONS);
        int w = random.nextInt(NUM_SIDE_OPTIONS);

        return new Tile(n, e, s, w);
    }
    
    /**
     * @param orientation set new orientation
     */
    public void setOrientation(int orientation){
        this.orientation = orientation;
    }
    
    /**
     * @return return current orientation
     */
    public int getOrientation(){
        return this.orientation;
    }
    
    /**
     * @param side
     * @return sideOption for given side
     */
    public int getSide(int side){
        return sides.get(getSideIndex(side));
    }
    
    /**
     * @param side
     * @return player who owns side, null if noone
     */
    public Player getOwner(int side){
        return owners.get(getSideIndex(side));
    }

    /**
     * @param sideOption Tile.ROAD, Tile.CITY
     * @return owner of sideOption
     */
    public Player getOwnerBySideOption(int sideOption){
        for(int i = 0; i < NUM_SIDES; i++){
            if(getSide(i) == sideOption){
                return getOwner(i);
            }
        }
        return null;
    }
    
    /**
     * @param side - side index
     * @param owner - Player object
     * set owner of side to owner
     */
    public void setOwner(int side, Player owner){
        owners.set(getSideIndex(side), owner);
    }

    /**
     * @param sideOption either Tile.ROAD, Tile.CITY
     * @param owner Player object
     * set owner of all roads or cities on this tile to owner
     */
    public void setSideOptionOwner(int sideOption, Player owner){
        for(int i = 0; i < NUM_SIDES; i++){
            if(getSide(i) == sideOption){
                setOwner(i, owner);
            }
        }
    }

    /**
     * rotate this tile clockwise
     */
    public void rotateCW(){
        setOrientation((getOrientation() + 3) % NUM_SIDES);
    }

    /**
     * rotate this tile counter clockwise
     */
    public void rotateCCW(){
        setOrientation((getOrientation() + 1) % NUM_SIDES);
    }

    /**
     * @param sideOption - Tile.ROAD. Tile.CITY, Tile.GRASS
     * @return true if contians sideOption false otherwise
     */
    public boolean containsSideOption(int sideOption){
        return sides.contains(sideOption);
    }

    /**
     * @param side
     * @return index of array that side is stored at based on
     * orientation
     */
    private int getSideIndex(int side){
        return (getOrientation() + side) % NUM_SIDES;
    }

    /**
     * create empty owner array and set to this.owners
     */
    private void createEmptyOwnersArray(){
        this.owners = new ArrayList<Player>();
        for(int i = 0; i < NUM_SIDES; i++){
            owners.add(null);
        }
    }
}
