import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;


public class SortingTest {

    @Test
    public void testInsertionSort() {
        // create random list
        int listLength = 10;
        List<Integer> list = ArrayUtils.randomIntegerList(listLength, 100);
        //ArrayUtils.printArray(list);
        // Sort List
        Sorting.insertionSort(list);
        //ArrayUtils.printArray(list);
        // check that list is increasing
        for(int i = 0; i < listLength-1; i++){
            Assert.assertTrue(list.get(i) <= list.get(i+1));
        }
    }

    @Test 
    public void testMergeSort() {
        // create random list
        int listLength = 20;
        List<Integer> list = ArrayUtils.randomIntegerList(listLength, 1000);
        
        //ArrayUtils.printArray(list);
        
        // Sort List
        Sorting.mergeSort(list);
        
        //ArrayUtils.printArray(list);

        // check that list is increasing
        for(int i = 0; i < listLength-1; i++){
            Assert.assertTrue(list.get(i) <= list.get(i+1));
        }
    }

    @Test
    public void testQuickSort() {
        // create random list
        int listLength = 20;
        List<Integer> list = ArrayUtils.randomIntegerList(listLength, 1000);
        
        //ArrayUtils.printArray(list);
        
        // Sort List
        Sorting.quickSort(list);
        
        //ArrayUtils.printArray(list);
        
        // check that list is increasing
        for(int i = 0; i < listLength-1; i++){
            Assert.assertTrue(list.get(i) <= list.get(i+1));
        }
    }


    @Test
    public void testSwapReferences(){
        List<Integer> list = new ArrayList<>();
        list.add(0);
        list.add(1);
        list.add(2);
        list.add(3);
        Sorting.swapReferences(list, 0, 1);
        Assert.assertEquals(1, (int)list.get(0));
        Assert.assertEquals(0, (int)list.get(1));
        Sorting.swapReferences(list, 2, 3);
        Assert.assertEquals(3, (int)list.get(2));
        Assert.assertEquals(2, (int)list.get(3));
    }

}
