// require filesystem module
var fs = require('fs');

// read in file as string
var filePath = process.argv[2];
var file = fs.readFileSync(filePath).toString();

// print out number of lines
console.log(file.split('\n').length - 1);
