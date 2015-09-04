import java.awt.Color;


public class Player {
    int score;
    Color color;
    String name;

    /**
     * construct a Player object with name and color
     * @param name
     * @param color
     */
    public Player(String name, Color color){
        setName(name);
        setColor(color);
    }


    /**
     * increment this players score by additionalPoints
     * @param additionalPoints
     */
    public void incrementScore(int additionalPoints){
        this.score += additionalPoints;
    }

    /**
     * @return player's score
     */
    public int getScore(){
        return this.score;
    }

    /**
     * reset score to 0
     */
    public void resetScore(){
        this.score = 0;
    }

    /**
     * @param color set this players color
     */
    public void setColor(Color color){
        this.color = color;
    }

    /**
     * @return player's color
     */
    public Color getColor(){
        return this.color;
    }

    /**
     * @return player's name
     */
    public String getName(){
        return this.name;
    }

    /**
     * @param name player's new name
     */
    public void setName(String name){
        this.name = name;
    }
}
