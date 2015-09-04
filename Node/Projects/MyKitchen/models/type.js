var mongoose = require('mongoose');

var typeSchema = mongoose.Schema({
    name: { type: String, index: true }
});

module.exports = mongoose.model('Type', typeSchema);
