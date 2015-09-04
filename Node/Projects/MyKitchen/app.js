var mongoose = require('mongoose'),
    recipe = require('models/recipe.js');
    ingredient = require('models/ingredient.js');

mongoose.connect('mongodb://localhost/KitchenDB', function(err) {
    if(err) {
        console.log('Failed to connect to KitchenDB', err);
    } else {
        console.log('Connected to KitchenDB');
    }
});
