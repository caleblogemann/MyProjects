// get numbers put into array
var numberArray = process.argv.slice(2);
// variable for sum
var sum = 0;
numberArray.forEach(function(element, index, array) {
    sum += Number(element);
});
console.log(sum);
