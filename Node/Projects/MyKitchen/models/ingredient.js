var mongoose = require('mongoose');

var ingredientSchema = mongoose.Schema({
    name: {type: String, index: true},
    amount: Number,
    unit: String
});

module.exports = mongoose.model('Ingredient', ingredientSchema);
