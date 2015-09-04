var mongoose = require('mongoose'),
    readlineSync = require('readline-sync'),
    recipeController = require('./controllers/recipe');

mongoose.connect('mongodb://localhost/KitchenDB');

/*var createRecipe = function(callback){
    var name = prompt('Name of recipe: ');
    var cookTime = prompt('Enter cooking time in minutes: ');
    var prepTime = prompt('Enter prep time in minutes: ');
    var servingSize = prompt('Enter number of people that this recipe feeds: ');
    
    // get recipe type
    var typeArray = ['breakfast', 'lunch', 'dinner', 'dessert'];
    console.log('What type of recipe is this');
    typeArray.forEach(function(type, index, typeArray){
        console.log(index + ':' + type);
    });
    var typeIndex = prompt('Input type: ');
    var type = typeArray[typeIndex];

    // get recipe category
    var categoryArray = ['Asian', 'Italian', 'American'];
    console.log('What category does this recipe belong to?');
    categoryArray.forEach(function(type, index, typeArray){
        console.log(index + ':' + type);
    });
    var categoryIndex = prompt('Input category: ');
    var category = categoryArray[categoryIndex];

    var instruction = prompt('Write instructions: ');

    recipeController.create(name, cookTime, prepTime, servingSize, null, type, 
        category, instructions, function(err, success){
            if(err){
                console.log(err);
            } else {
                console.log('Recipe Saved');
            }
    });

};*/

var db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', function(callback){
    console.log('Creating recipe');
    recipeController.create('Waffles', 10, 10, 2, null, 'lunch', 'american',
        'make waffles', function(err, result){
            if(err){
                console.log(err);
            } else {
                console.log(result);
                console.log('listing..');
                recipeController.list(function(err, result){
                    console.log('listing');
                    if(err){
                        console.log(err);
                    } else {
                        console.log(result);
                        db.close();
                    }
                });
            }
    });

    var terminationCondition = false;
    //createRecipe();
    /*while(!terminationCondition){
        console.log('1: Add new recipe');
        console.log('2: List recipes');
        console.log('-1 to quit');
        var input = prompt('Input Number: ');
        console.log(typeof input);
        switch(input){
            case -1:
                terminationCondition = true;
                break;
            case 1:
                createRecipe();
                break;
            case 2:
                recipeController.list(function(err, results){
                    if(err) {
                        console.log(err);
                    } else {
                        console.log(results);
                    }
                });
                break;
            default:
                console.log('That is not a valid input number');
        }
    }*/
    //db.close();
});
