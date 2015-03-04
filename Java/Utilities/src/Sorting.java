/**
 * @author Caleb Logemann
 * @version 0.1
 * @date 02/27/15
 * Sorting Algorithms
 * A collection of sorting algorithms
 * All methods take in generic lists of comparable objects
 * List is sorted after algorithm has finished
*/

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Collections;

public class Sorting {

    // TODO
    // Bubble Sort
    // Shell Sort
    // Add methods to take in primitive arrays as well

    /**
     * Constant for use in quickSort algorithm
     * what size array will be sorted by insertion sort
     * instead of quickSort
     */
    private static final int CUTOFF = 3;

    /**
     * Sort a list using insertion sort algorithm
     * Good for small lists
     * Driver method
     * Worst Case - O(n^2)
     * @param a list to sort
     */
    public static <T extends Comparable<? super T>> void insertionSort(List<T> a){
        insertionSort(a, 0, a.size()-1);
    }

    /**
     * Sort a list using insertion sort algorithm
     * Sorts portion of list between low and high inclusive
     * Good for small lists
     * @param a list to sort
     */
    protected static <T extends Comparable<? super T>> void insertionSort(List<T> a, int low, int high){
        // Example of insertion sort
        // 4 1 3 2 5
        // 1 4 3 2 5
        // 1 3 4 2 5
        // 1 2 3 4 5

        // index low is already sorted
        // move from left to right inserting in correct position 
        // list is always sorted from low to i
        for (int i = low + 1; i <= high; i++){
            // store object at index i
            T tmp = a.get(i);

            // start at i if j - 1 is greater then tmp move index j - 1 to j
            int j;
            for(j = i; j > 0; j--){
                // tmp < j - 1 -> compareTo < 0
                // tmp > j - 1 -> compareTo > 0
                if(tmp.compareTo(a.get(j - 1)) < 0){
                    a.set(j, a.get(j-1));
                } else {
                    // break if tmp is bigger than j - 1
                    
                    break;
                }
            }
            
            // tmp should be inserted into position j
            a.set(j, tmp);
        }
    }

    /**
     *
     * Subquadractic sorting algorithm
     */
    public static <T extends Comparable<? super T>> void shellSort(List<T> a){

    }

    /**
     * Sort a list using the mergeSort algorithm
     * Driver Method
     * Always in O(n log(n))
     * @param a list to sort
     */
    public static <T extends Comparable<? super T>> void mergeSort(List<T> a){
        // create tmp array 
        List<T> tmpArray = new ArrayList<>();
        for(int i = 0; i < a.size(); i++){
            tmpArray.add(null);
        }

        // call mergeSort method
        mergeSort(a, tmpArray, 0, a.size()-1);
    }

    /**
     * Sort a list using the mergeSort algorithm
     * Recursive Method
     * Always in O(n log(n))
     * @param a list to sort
     * @param tmpArray - tmp array to allow for merging
     * @param low lower bound to sort
     * @param high upper bound to sort
     */
    public static <T extends Comparable<? super T>> void mergeSort(List<T> a,
            List<T> tmpArray, int low, int high){
        // base case if high - low < 1 then already sorted
        if(high - low < 1){
            return;
        }

        // else split array and sort each half and then merge the halves back together
        int center = (low + high)/2;
        mergeSort(a, tmpArray, low, center);
        mergeSort(a, tmpArray, center + 1, high);
        merge(a, tmpArray, low, high);
    }

    protected static <T extends Comparable<? super T>> void merge(List<T> a,
            List<T> tmpArray, int low, int high){
        // Example
        // low = 0, high = 5, leftPos = 0, leftEnd = 2, rightPos = 3,
        // rightEnd = 5, tmpPos = 0
        // a - 1 3 4 2 5 6 
        // tmpArray - 0 0 0 0 0 0
        // a.leftPos < a.rightPos, 
        // tmpArray - 1 0 0 0 0 0
        // leftPos = 1, rightPos = 3, tmpPos = 1
        // a.rightPos < a.leftPos
        // tmpArray - 1 2 0 0 0 0
        // leftPos = 1, rightPos = 4, tmpPos = 2
        // a.leftPos < a.rightPos
        // tmpArray - 1 2 3 0 0 0
        // leftPos = 2, rightPos = 4, tmpPos = 3
        // a.leftPos < a.rightPos
        // tmpArray - 1 2 3 4 0 0
        // leftPos = 3, rightPos = 4, tmpPos = 4
        // leftPos < leftEnd so copy remainder of rightArray
        // tmpArray - 1 2 3 4 5 0
        // tmpArray - 1 2 3 4 5 6
        // copy tmpArray back over a
        // a - 1 2 3 4 5 6

        // find two subarrays of array a that are to be merged
        int leftEnd = (low + high)/2;
        int leftPos = low;
        int rightPos = leftEnd + 1;
        int rightEnd = high;

        // merge into beginning of tmpArray
        int tmpPos = 0;
        int numElements = high - low + 1;

        while(leftPos <= leftEnd && rightPos <= rightEnd){
            // if value at leftPos is less than rightPos
            // copy leftPos into tmpArray and increment leftPos
            if(a.get(leftPos).compareTo(a.get(rightPos)) <= 0){
                tmpArray.set(tmpPos, a.get(leftPos));
                leftPos++;
                
            } else { // else rightPos is less and should be copied
                tmpArray.set(tmpPos, a.get(rightPos));
                rightPos++;
            }

            // in either case increment tmpPos
            tmpPos++;
        }

        // copy rest of left array if right array finished first
        while(leftPos <= leftEnd){
            tmpArray.set(tmpPos, a.get(leftPos));
            // increment left and tmp position
            leftPos++;
            tmpPos++;
        }

        // copy rest of right array if left array finished first
        while(rightPos <= rightEnd){
            tmpArray.set(tmpPos, a.get(rightPos));
            // increment right and tmp position
            rightPos++;
            tmpPos++;
        }

        // copy tmpArray back into array a
        for(int i = 0; i < numElements; i++){
            a.set(low+i, tmpArray.get(i));
        }
    }

    /**
     * Sort a list using the quicksort algorithm
     * driver function
     * @param a list to sort
     */
    public static <T extends Comparable<? super T>> void quickSort(List<T> a){
        quickSort(a, 0, a.size() - 1);
    }

    
    /**
     * Sort a list using the quicksort algorithm
     * @param a list to sort
     * @param low lower bound to sort
     * @param high upper bound to sort
     */
    protected static <T extends Comparable<? super T>> void quickSort(List<T> a,
            int low, int high){
        // Example
        // low = 0, high = 5, center = 2
        // a - 1 3 4 2 5 6 
        // a[low] = 1, a[center] = 4, a[high] = 6
        // sort if necessary
        // 4 is median, place median in position high - 1
        // pivot = 4
        // a - 1 3 5 2 4 6
        // Let i = low + 1, and j = high - 2
        // a[i] = 3, a[j] = 2
        // increment i until a[i] > pivot
        // i = 2
        // decrement j until a[j] < pivot
        // j = 3
        // swap a[i] and a[j]
        // a - 1 3 2 5 4 6
        // continue
        // i = 3
        // j = 2
        // when i and j cross
        // replace median at position i
        // a - 1 3 2 4 5 6
        // sort low to i - 1
        // sort i + 1 to high
        // a - 1 2 3 4 5 6

        // If length of array is short enough use insertion sort
        if(high - low < CUTOFF){
            insertionSort(a, low, high);
            return;
        } 

        // Median of three
        int center = (high + low)/2;
        // sort low, center, high
        // 3 2 1
        // if low is greater than center
        if(a.get(low).compareTo(a.get(center)) > 0){
            swapReferences(a, low, center);
            // low is less than center
            // 2 3 1
        }
        // if center is greater than high
        if(a.get(center).compareTo(a.get(high)) > 0){
            swapReferences(a, center, high);
            // high is largest
            // 2 1 3
        }
        // if low is greater than center
        if(a.get(low).compareTo(a.get(center)) > 0){
            swapReferences(a, low, center);
            // low is less than center
            // 1 2 3
        }

        // center is median and will be used as pivot
        // place pivot at position high - 1
        swapReferences(a, center, high - 1);
        // store pivot value for easy accesss
        T pivot = a.get(high - 1);

        // partition array into elements smaller than and greater than pivot
        // low is already less than pivot
        // high is already greater than pivot
        int i = low + 1;
        int j = high - 2;
        while(true){
            // scan i to the right until object greater than pivot is found
            // when loop stops i will be pointing at element greater than pivot
            while(a.get(i).compareTo(pivot) < 0){
                i++;
            }

            // scan j to the left until object less than pivot is found
            // when loop stops j will be pointing to an element less than pivot
            while(a.get(j).compareTo(pivot) > 0){
                j--;
            }

            // if i and j cross than partitioning is complete
            if(i >= j){
                break;
            }

            swapReferences(a, i, j);

            // after swapping move to next position to check
            i++;
            j--;
        }

        // Put pivot in between elements less than and greater than itself
        // i is greater than so should belong above pivot
        swapReferences(a, high - 1, i);
        
        // Recursively sort element smaller than pivot and greater than pivot
        quickSort(a, low, i - 1);
        quickSort(a, i+1, high);
    }

    /**
     * Method to swap two indices in a list
     * @param array - the list to be modified
     * @param a - first index
     * @param b - second index
     */
    protected static void swapReferences(List<?> array, int a, int b){
        Collections.swap(array, a, b);
    }
}
