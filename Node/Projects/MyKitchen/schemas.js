var mongoose = require('mongoose');

var ingredientSchema = mongoose.Schema({
    name: {type: String, index: true},
    amount: Number,
    unit: String
});

var recipeSchema = mongoose.Schema({
    name: {type: String, index: true},
    // time to cook
    cookTime: Number,
    // time to prepare make
    prepTime: Number,
    // number of people recipe serves
    servingSize: Number,
    ingredients: [ingredientSchema],
    // breakfast, lunch, dinner, desert
    type: String,
    // American, Italian, Asian, etc.
    category: String,
    instructions: String
});

var ingredient = mongoose.model('Ingredient', ingredientSchema);
var recipe = mongoose.model('Recipe', recipeSchema);

mongoose.connect('localhost', 'kitchenDB');
