import java.awt.Color;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.swing.table.AbstractTableModel;


public class Game extends AbstractTableModel {
    // player 1 - blue
    private Player player1;

    // player 2 - red
    private Player player2;

    // Stores reference to player whose turn it is
    private Player currentPlayer;

    // store current size of board
    private int size;
    
    // store the number of tiles played
    private int numTilesPlayed;

    // store list of tiles
    // null is empty space
    List<List<Tile>> tiles;
    
    // tile to be placed next
    Tile currentTile;

////////////////////////////////////////////////////////////////////////////////
// Constructors
////////////////////////////////////////////////////////////////////////////////

    /**
     * Default constructor
     */
    public Game(){
        // Default initial size
        this(3);
    }

    /**
     * construct a game whose board has a length/width of size
     * @param size - board width
     */
    public Game(int size){
        player1 = new Player("Player 1", Color.RED);
        player2 = new Player("Player 2", Color.BLUE);
        setCurrentPlayer(player1);
        setSize(size);
        createNewTileArray(size);
        generateNewCurrentTile();
    }

////////////////////////////////////////////////////////////////////////////////
// Getters and Setters
////////////////////////////////////////////////////////////////////////////////

    /**
     * @return player1 object
     */
    public Player getPlayer1(){
        return this.player1;
    }

    /**
     * @return player2 object
     */
    public Player getPlayer2(){
        return this.player2;
    }

    /**
     * @return player object whose turn it is
     */
    public Player getCurrentPlayer(){
        return this.currentPlayer;
    }

    /**
     * set currentPlayer
     * @param currentPlayer player whose turn it will be
     */
    private void setCurrentPlayer(Player currentPlayer){
        this.currentPlayer = currentPlayer;
    }

    /**
     * @return width/length of board
     */
    public int getSize(){
        return this.size;
    }

    /**
     * @param size - new size
     */
    private void setSize(int size){
        this.size = size;
    }

    /**
     * @return number of tiles currently played
     */
    private int getNumTilesPlayed(){
        return this.numTilesPlayed;
    }
    
    /**
     * @param numTilesPlayed update number of tiles currently played
     */
    private void setNumTilesPlayed(int numTilesPlayed){
        this.numTilesPlayed = numTilesPlayed;
    }
    
    /**
     * increase number of tiles played by one
     */
    private void incrementNumTilesPlayed(){
        this.numTilesPlayed++;
    }

    /**
     * place new tile on board
     * @param newTile - new tile to place
     * @param rowIndex - row to place in 
     * @param columnIndex - column to place in
     */
    private void setTileAt(Tile newTile, int rowIndex, int columnIndex){
        tiles.get(rowIndex).set(columnIndex, newTile);
        fireTableDataChanged();
    }

    /**
     * @param rowIndex
     * @param columnIndex
     * @return tile at (rowIndex, columnIndex), null if no tile is present
     */
    private Tile getTileAt(int rowIndex, int columnIndex){
        return tiles.get(rowIndex).get(columnIndex);
    }

    /**
     * @return tile to be placed next
     */
    public Tile getCurrentTile(){
        return this.currentTile;
    }

    /**
     * @param tile set next tile to be placed
     */
    private void setCurrentTile(Tile tile){
        this.currentTile = tile;
    }

    /**
     * rotate currentTile clockwise
     */
    public void rotateCurrentTileCW(){
        currentTile.rotateCW();
    }

    /**
     * rotate currentTile counter clockwise
     */
    public void rotateCurrentTileCCW(){
        currentTile.rotateCCW();
    }

///////////////////////////////////////////////////////////////////////////////
// Main Methods
///////////////////////////////////////////////////////////////////////////////

    /**
     * @return true is board is full false otherwise
     */
    public boolean isGameFinished(){
        // size^2 is the total number of tiles that can be played
        return numTilesPlayed >= Math.pow(getSize(), 2);
    }

    /**
     * @return player with the most points
     */
    public Player getWinner(){
        if(isGameFinished()){
            if(player1.getScore() >= player2.getScore()){
                return player1;
            } else {
                return player2;
            }
        }
        return null;
    }

    /**
     * reset board start new game of same size
     */
    public void reset(){
        reset(getSize());
    }

    /**
     * reset board start new game of input size
     * @param size - new size
     */
    public void reset(int size){
        createNewTileArray(size);
        generateNewCurrentTile();
        player1.resetScore();
        player2.resetScore();
        setCurrentPlayer(player1);
        fireTableStructureChanged();
    }
    
    /**
     * @param rowIndex
     * @param columnIndex
     * @return true if current tile is playable in its current state
     * at (rowIndex, columnIndex) false otherwise
     */
    public boolean isPlayable(int rowIndex, int columnIndex){
        return isPlayable(getCurrentTile(), rowIndex, columnIndex);
    }

    /**
     * main method simulates one players turn
     * inserts current tile at rowIndex, columnIndex if playable
     * @param rowIndex
     * @param columnIndex
     */
    public void insertTile(int rowIndex, int columnIndex){
        if(isPlayable(rowIndex, columnIndex)){
            setTileAt(getCurrentTile(), rowIndex, columnIndex);
            incrementNumTilesPlayed();
            
            // update owners
            updateOwners(rowIndex, columnIndex);

            // update scores
            updateScores(rowIndex, columnIndex);

            if(!isGameFinished()){
                generateNewCurrentTile();
                // change whose turn it is
                swapTurns();
            } else {
                setCurrentTile(null);
            }
        }
    }

    /**
     * update the owners of tile at (rowIndex, columnIndex)
     * usually right after this tile has been placed
     * @param rowIndex
     * @param columnIndex
     */
    private void updateOwners(int rowIndex, int columnIndex){
        Tile tile = getTileAt(rowIndex, columnIndex);

        // update cities
        if(tile.containsSideOption(Tile.CITY)){
            updateOwners(rowIndex, columnIndex, Tile.CITY);
        }

        // update roads
        if(tile.containsSideOption(Tile.ROAD)){
            updateOwners(rowIndex, columnIndex, Tile.ROAD);
        }
    }

    /**
     * update scoring caused by placing tile at (rowIndex, columnIndex)
     * @param rowIndex
     * @param columnIndex
     */
    private void updateScores(int rowIndex, int columnIndex){
        Tile tile = getTileAt(rowIndex, columnIndex);
        // was road finished
        if(tile.containsSideOption(Tile.ROAD)){
            Set<Tile> roadSet = new HashSet<Tile>();
            roadSet = isFinished(rowIndex, columnIndex, Tile.ROAD, roadSet);
            if(!roadSet.isEmpty()){
                Player owner = tile.getOwnerBySideOption(Tile.ROAD);
                if(owner != null){
                    owner.incrementScore(roadSet.size());
                }
            }
        }

        // was city finished
        if(tile.containsSideOption(Tile.CITY)){
            Set<Tile> citySet = new HashSet<Tile>();
            citySet = isFinished(rowIndex, columnIndex, Tile.CITY, citySet);
            if(!citySet.isEmpty()){
                Player owner = tile.getOwnerBySideOption(Tile.CITY);
                if(owner != null){
                    owner.incrementScore(citySet.size());
                }
            }
        }
    }

    /**
     * update owners of either city or road on tile just placed on
     * (rowIndex, columnIndex)
     * @param rowIndex
     * @param columnIndex
     * @param sideOption - either Tile.ROAD or Tile.CITY
     */
    private void updateOwners(int rowIndex, int columnIndex, int sideOption){
        // determine owner to be set
        Tile tile = getTileAt(rowIndex, columnIndex);
        List<Player> adjacentOwners = new ArrayList<Player>();
        for(int i = 0; i < Tile.NUM_SIDES; i++){
            // If side corresponds to sideOption
            if(tile.getSide(i) == sideOption){
                adjacentOwners.add(getAdjacentOwner(rowIndex, columnIndex, i));
            }
        }

        // if conflict in ownership set owners to null
        if(adjacentOwners.contains(getPlayer1()) && adjacentOwners.contains(getPlayer2())) {
            setOwnerRecursively(rowIndex, columnIndex, sideOption, null);
        // if opposite player owns adjacent then opposite player gets this tile
        } else if (adjacentOwners.contains(getOppositePlayer())) {
            setOwnerRecursively(rowIndex, columnIndex, sideOption, getOppositePlayer());
        // otherwise adjacent to current player or to null so set to current Player
        } else {
            setOwnerRecursively(rowIndex, columnIndex, sideOption, getCurrentPlayer());
        }
    }

    /**
     * recursively update owners of tiles connected to a tile being set
     * @param rowIndex
     * @param columnIndex
     * @param sideOption - either Tile.ROAD or Tile.CITY
     * @param newOwner - new Owner of road or city
     */
    private void setOwnerRecursively(int rowIndex, int columnIndex,
        int sideOption, Player newOwner){
        
        Tile tile = getTileAt(rowIndex, columnIndex);
        tile.setSideOptionOwner(sideOption, newOwner);
        for(int i = 0; i < Tile.NUM_SIDES; i++){
            // if adjacentOwner doesn't match set the owner of that tile
            // check to see if at edge of board
            if(SetOwnerQ(rowIndex, columnIndex, i, sideOption, newOwner)) {
                setOwnerRecursively(getAdjacentRowIndex(rowIndex, i),
                    getAdjacentColumnIndex(columnIndex, i), sideOption, newOwner);
            }
        }
    }

    /**
     * determines if road or city on (rowIndex, columnIndex) has been completed
     * @param rowIndex
     * @param columnIndex
     * @param sideOption - either Tile.CITY or Tile.ROAD
     * @param tileSet - set of tiles already checked
     * @return set of tiles, if empty than not finished, set of tiles is used
     * to determine scoring
     */
    private Set<Tile> isFinished(int rowIndex, int columnIndex, int sideOption,
            Set<Tile> tileSet){
        Tile tile = getTileAt(rowIndex, columnIndex);
        // add this tile to set already checked
        tileSet.add(tile);

        // check all sides
        for(int i = 0; i < Tile.NUM_SIDES; i++){
            if(tile.getSide(i) == sideOption) {
                // if not finished then empty set and return
                if(isSideOpen(rowIndex, columnIndex, i)){
                    tileSet.clear();
                    return tileSet;
                } else if (checkFinished(rowIndex, columnIndex, i, tileSet)) {
                    // if attached to another tile check that tile
                    tileSet = isFinished(getAdjacentRowIndex(rowIndex, i),
                        getAdjacentColumnIndex(columnIndex, i), sideOption,
                        tileSet);
                    // if detected not finished on this branch then return
                    if(tileSet.isEmpty()){
                        return tileSet;
                    }
                }
            }
        }

        return tileSet;
    }

///////////////////////////////////////////////////////////////////////////////
// Abstract Table Model Classes
///////////////////////////////////////////////////////////////////////////////

    /* (non-Javadoc)
     * @see javax.swing.table.TableModel#getRowCount()
     */
    @Override
    public int getRowCount() {
        return size;
    }

    /* (non-Javadoc)
     * @see javax.swing.table.TableModel#getColumnCount()
     */
    @Override
    public int getColumnCount() {
        return size;
    }

    /* (non-Javadoc)
     * @see javax.swing.table.TableModel#getValueAt(int, int)
     */
    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
        return tiles.get(rowIndex).get(columnIndex);
    }
    
    /* (non-Javadoc)
     * @see javax.swing.table.AbstractTableModel#getColumnClass(int)
     */
    public Class<?> getColumnClass(int columnIndex){
        return Tile.class;
    }

///////////////////////////////////////////////////////////////////////////////
// Utilities Methods
///////////////////////////////////////////////////////////////////////////////

    /**
     * @param tile tile to check
     * @return true if tile is playable anywhere on the board at
     * any rotation
     */
    private boolean isPlayable(Tile tile){
        // check rows
        for(int i = 0; i < size; i++){
            // check columns
            for(int j = 0; j < size; j++){
                // check orientations
                int originalOrientation = tile.getOrientation();
                for(int k = 0; k < Tile.NUM_SIDES; k++){
                    tile.setOrientation(k);
                    if(isPlayable(tile, i, j)){
                        tile.setOrientation(originalOrientation);
                        return true;
                    }
                }
            }
        }
        return false;
    }

    /**
     * @param tile tile to check
     * @param row
     * @param col
     * @return true if tile at current orientation is playable
     * at (row, col), false otherwise
     */
    private boolean isPlayable(Tile tile, int row, int col){
        // check if space is already been played
        if(tiles.get(row).get(col) != null){
            return false;
        }
        
        // check if next to another tile
        // needs to be next to at least one other tile
        boolean isNextToAnotherTile = false;
        
        for(int i = 0; i < Tile.NUM_SIDES; i++){
            int sideOption = getAdjacentSideOption(row, col, i);
            if(sideOption != -1) {
                isNextToAnotherTile = true;
                if(sideOption != tile.getSide(i)){
                    return false;
                }
            }
        }

        if(!isNextToAnotherTile){
            return false;
        }
        
        return true;
    }

    /**
     * @param owner1 - first Player
     * @param owner2 - second Player
     * @return true if Player objects are the same even if both null, 
     * false otherwise
     */
    private boolean ownersMatch(Player owner1, Player owner2){
        // if both null than equal
        if(owner1 == null && owner2 == null){
            return true;
        // if only one null than not equal
        } else if (owner1 == null || owner2 == null){
            return false;
        }
        return owner1.equals(owner2);
    }

    /**
     * @param rowIndex
     * @param columnIndex
     * @param side - which side to look at
     * @return true if tile at (rowIndex, columnIndex) is against edge of board
     * for side
     */
    private boolean atBoardEdge(int rowIndex, int columnIndex, int side){
        switch(side) {
            // top side so if rowIndex is equal to zero, tile is at board edge
            case 0:
                return rowIndex <= 0;
            // right side so if columnIndex is equal to size-1, tile is at edge
            case 1:
                return columnIndex >= getSize() - 1;
            // bottom side so if rowIndex is equal to size-1, tile is at edge
            case 2:
                return rowIndex >= getSize() - 1;
            // left side so if columnIndex is equal to zeor, tile is at edge
            case 3:
                return columnIndex <= 0;
        }
        // TODO: consider throwing exception if not one of these cases
        return true;
    }

    /**
     * @param rowIndex
     * @param columnIndex
     * @param side - side to check
     * @param sideOption - either Tile.ROAD or Tile.CITY
     * @param newOwner new owner
     * @return true if should set owner of adjacent tile, false otherwise
     */
    private boolean SetOwnerQ(int rowIndex, int columnIndex, int side, int sideOption, Player newOwner){
        // if at boards edge or owners match or adjacent tile is null than dont
        // set owners
        boolean atBoardEdge = atBoardEdge(rowIndex, columnIndex, side);
        boolean ownersMatch = ownersMatch(newOwner,
            getAdjacentOwner(rowIndex, columnIndex, side));
        boolean adjacentTileNull = isAdjacentTileNull(rowIndex,columnIndex, side);
        boolean sideOptionsMatch = getTileAt(rowIndex, columnIndex).getSide(side)
            == sideOption;

        return !atBoardEdge && !ownersMatch && !adjacentTileNull && sideOptionsMatch;
    }

    /**
     * @param rowIndex
     * @param columnIndex
     * @param side - side to check, 1, 2, 3, 4
     * @return true if next adjacent to open tile
     */
    private boolean isSideOpen(int rowIndex, int columnIndex, int side){
        boolean atBoardEdge = atBoardEdge(rowIndex, columnIndex, side);
        boolean adjacentTileNull = isAdjacentTileNull(rowIndex, columnIndex, side);
        return !atBoardEdge && adjacentTileNull;
    }

    /**
     * @param rowIndex
     * @param columnIndex
     * @param side
     * @return true if adjacent tile is null false otherwise
     * could be null because at edge of board
     */
    private boolean isAdjacentTileNull(int rowIndex, int columnIndex, int side){
        return getAdjacentTile(rowIndex, columnIndex, side) == null;
    }

    /**
     * @param rowIndex
     * @param columnIndex
     * @param side - adjacent side
     * @param tileSet set of tiles already checked
     * @return true if should check if finished false otherwise
     */
    private boolean checkFinished(int rowIndex, int columnIndex, int side,
            Set<Tile> tileSet){
        boolean adjacentTileNull = isAdjacentTileNull(rowIndex, columnIndex, side);
        boolean alreadyChecked = tileSet.contains(
                getAdjacentTile(rowIndex,columnIndex, side));
        return !adjacentTileNull && !alreadyChecked;
    }

    /**
     * @param side
     * @return int index of side opposite of input side
     */
    private int getOppositeSideIndex(int side){
        return (side + 2) % Tile.NUM_SIDES;
    }

    /**
     * @return player opposite of currentPlayer
     */
    private Player getOppositePlayer(){
        if(getCurrentPlayer().equals(getPlayer1())){
            return getPlayer2();
        }
        return getPlayer1();
    }

    /**
     * Switch currentPlayer to opposite player
     */
    private void swapTurns(){
        if(getCurrentPlayer().equals(player1)){
            setCurrentPlayer(player2);
        } else {
            setCurrentPlayer(player1);
        }
    }

    /**
     * @param rowIndex
     * @param columnIndex
     * @param side
     * @return tile that is adjacent to (rowIndex, columnIndex) on side
     */
    private Tile getAdjacentTile(int rowIndex, int columnIndex, int side){
        if(atBoardEdge(rowIndex, columnIndex, side)){
            return null;
        }
        return getTileAt(getAdjacentRowIndex(rowIndex, side),
            getAdjacentColumnIndex(columnIndex, side));
    }

    /**
     * @param rowIndex
     * @param columnIndex
     * @param side
     * @return return Tile.ROAD, Tile.CITY, Tile.GRASS of side adjacent
     * to tile (rowIndex, columnIndex)
     */
    private int getAdjacentSideOption(int rowIndex, int columnIndex, int side){
        Tile adjacentTile = getAdjacentTile(rowIndex, columnIndex, side);
        if(adjacentTile != null){
            return adjacentTile.getSide(getOppositeSideIndex(side));
        }
        return -1;
    }

    /**
     * @param rowIndex
     * @param columnIndex
     * @param side
     * @return Player who owns side adjacent to (rowIndex, columnIndex)
     */
    private Player getAdjacentOwner(int rowIndex, int columnIndex, int side){
        Tile adjacentTile = getAdjacentTile(rowIndex, columnIndex, side);
        if(adjacentTile != null){
            return adjacentTile.getOwner(getOppositeSideIndex(side));
        }
        return null;
    }

    /**
     * @param rowIndex
     * @param side
     * @return get index of row, adjacent to rowIndex based on side
     */
    private int getAdjacentRowIndex(int rowIndex, int side){
        switch(side){
            // top side return rowIndex - 1
            case 0:
                return rowIndex - 1;
            // bottom side return rowIndex + 1
            case 2:
                return rowIndex + 1;
            // left or right side return same index
            default:
                return rowIndex;
        }
    }

    /**
     * @param columnIndex
     * @param side
     * @return get index of column adjacent to columnIndex based on side
     */
    private int getAdjacentColumnIndex(int columnIndex, int side){
        switch(side){
            // right side return columnIndex + 1
            case 1:
                return columnIndex + 1;
            // left side return columnIndex - 1
            case 3:
                return columnIndex - 1;
            // if top or bottom side return same index
            default:
                return columnIndex;
        }
    }

    /**
     * Resetting board to size size
     * @param size - size of new board
     * create new board and set size
     */
    private void createNewTileArray(int size){
        setSize(size);
        setNumTilesPlayed(0);
        tiles = new ArrayList<List<Tile>>(size);
        for(int i = 0; i < size; i++){
            tiles.add(new ArrayList<Tile>(size));
            for(int j = 0; j < size; j++){
                tiles.get(i).add(null);
            }
        }
        
        insertRandomCenterTile();
    }
    
    /**
     * insert random tile in center of board
     */
    private void insertRandomCenterTile(){
        setTileAt(Tile.getRandomTile(), size/2, size/2);
        incrementNumTilesPlayed();
    }
    
    /**
     * generate a new playable tile to be next currentTile
     */
    private void generateNewCurrentTile(){
        Tile tile = Tile.getRandomTile();
        while(!isPlayable(tile)){
            tile = Tile.getRandomTile();
        }
        setCurrentTile(tile);
    }
}
// vim:foldlevel=0: set foldnestmax=2
