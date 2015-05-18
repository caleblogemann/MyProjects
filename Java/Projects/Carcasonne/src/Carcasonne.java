public class Carcasonne {

    public static void main(String [] args){
        // create game object - model class
        Game game = new Game();
        // create view class/gui to show game model
        View view = new View(game);
    }
}
