var mongoose = require('mongoose');
var ingredient = require('./ingredient');
var ingredientSchema = ingredient.schema;

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

module.exports = mongoose.model('Recipe', recipeSchema);
