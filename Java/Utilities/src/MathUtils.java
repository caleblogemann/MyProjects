import java.util.ArrayList;
import java.util.List;

public class MathUtils {

    public static boolean isPrime(int n){

        for(int i = 2; i < n/2; i++){
            if ( n % i == 0 ){
                return false;
            }
        }

        return true;
    }

    /**
     * Creates a list of factors of a given integer
     * @param n - positive integer to find factors
     * @return List of factors
     */
    public static List<Integer> listFactors(int n){
        List<Integer> factors = new ArrayList<>();
        factors.add(1);

        for(int i = 2; i <= n/2; i++){
            if( n % i == 0 ){
                factors.add(i);
            }
        }

        return factors;
    }

    /**
     * Finds the greatest common divisor(GCD) of two integers via Euclid's
     * Algorithm
     * @param a first integer
     * @param b second integer
     * @return greatest common divisor (GCD)
     */
    public static int GCD(int a, int b){
        /*
         * Example of Euclids Algorithm
         * a = 142, b = 63
         *   m = q *  n +  r
         * 142 = 2 * 63 + 16
         *  63 = 3 * 16 + 15
         *  16 = 1 * 15 +  1
         *  15 = 15 * 1 +  0
         *  GCD = 1 the value of n when r = 0
         */

        int m;
        int n;

        // find large integer 
        if(a < b){
            m = b;
            n = a;
        } else {
            m = a;
            n = b;
        }

        int r = m % n;
        while(r != 0){
            m = n;
            n = r;
            r = m % n;
        }

        return n;
    }

    /**
     * Find the least common multiple (LCM) of two integers
     * @param a first integer
     * @param b second integer
     * @return least common multiple (LCM)
     */
    public static int LCM(int a, int b){

        // check through all mutliples of a
        // if a multiple of a is also a multiple of b
        // return the first one found it must be the smallest
        for(int i = a; i < a*b; i+=a){
            if(i % b == 0){
                return i;
            }
        }

        // if none found then a * b must be least common multiple
        return a * b;
    }

    public static int factorial(int n) throws MathematicallyUndefinedException{
        if (n < 0){
            //System.out.println("Factorial is undefined for number less than 0");
            throw new MathematicallyUndefinedException("Factorial is undefined for number less than 0");
        }

        int factorial = 1;
        for(int i = 2; i <= n; i++){
            factorial *= i;
        }
        return factorial;
    }

    public static double generalizedBinomialCoefficient(double a, double b){

        return 0;
    }

    public static int combination(int n, int r) throws MathematicallyUndefinedException {
        if (r > n){
            //System.out.println("Combination is undefined for r greater than n");
            throw new MathematicallyUndefinedException("Combination is undefined for r greater than n");
        }
        
        // n C r = n!/((n-r)!r!)
        return factorial(n)/(factorial(n-r) * factorial(r));
    }

    public static int permutation(int n, int r) throws MathematicallyUndefinedException{
        if (r > n){
            //System.out.println("Permutation is undefined for r greater than n");
            throw new MathematicallyUndefinedException("Factorial is undefined for number less than 0");
        }
        return factorial(n)/factorial(n - r);
    }

    public static int combinationWithRepitition(int n, int r) throws MathematicallyUndefinedException {
        if (r > n){
            // System.out.println("Combination is undefined for r greater than n");
            throw new MathematicallyUndefinedException("Factorial is undefined for number less than 0");
        }

        return combination(n + r - 1, r);
    }

    public static int permutationWithRepitition(int n, int r) throws MathematicallyUndefinedException{
        if (r > n){
            //System.out.println("Permutation is undefined for r greater than n");
            throw new MathematicallyUndefinedException("Factorial is undefined for number less than 0");
        }

        return (int)Math.pow(n, r);
    }
}
