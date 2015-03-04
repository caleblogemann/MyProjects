import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class ArrayUtils{

    /**
     * Print 1D array
     * @param list to print
     */
    public static void printArray(List<?> a){
        for(int i = 0; i < a.size(); i++){
            System.out.print(a.get(i) + "\t");
        }
        System.out.println();
    }

    /**
     * Create a random list of integers
     * default lower bound of 0
     * @param length number of integers in list
     * @param upperBound highest integer not inclusive
     * @return list of integers
     */
    public static List<Integer> randomIntegerList(int length, int upperBound){
        return randomIntegerList(length, 0, upperBound);
    }

    /**
     * Create a random list of integers
     * @param length number of integers in list
     * @param lowerBound lowest integer inclusive
     * @param upperBound highest integer not inclusive
     * @return list of integers
     */
    public static List<Integer> randomIntegerList(int length, int lowerBound,
            int upperBound){

        List<Integer> list = new ArrayList<>();
        Random random = new Random();

        for(int i = 0; i < length; i++){
            list.add(lowerBound + random.nextInt(upperBound - lowerBound));
        }

        return list;
    }
}
