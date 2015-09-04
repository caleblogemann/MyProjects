var mongoose   = require('mongoose'),
    recipeDB   = require('../models/recipe'),
    ingredient = require('../models/ingredient');

var _this = {
    list:function(callback) {
        recipeDB.find(function(err, results){
            if(err){
                console.log(err);
                callback(err);
            } else {
                callback(null, results);
            }
        });
    },

    find:function(name) {
        
    },

    findByType:function(type) {
        
    },

    findByCategory:function(category) {
        
    },

    delete:function(name) {
        
    },

    create:function(name, cookTime, prepTime, servingSize, ingredients, type,
            category, instructions, callback) {
        var newRecipe = new Object();
        newRecipe.name = name;
        newRecipe.cookTime = cookTime;
        newRecipe.prepTime = prepTime;
        newRecipe.servingSize = servingSize;
        newRecipe.ingredients = ingredients;
        newRecipe.type = type;
        newRecipe.category = category;
        newRecipe.instructions = instructions;
        recipeDB.create(newRecipe, function(err, result){
            if(err){
                console.log(err);
                callback(err);
            } else {
                callback(null, 'success');
            }
        });
    }
};

module.exports = _this;
