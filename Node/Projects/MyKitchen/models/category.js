var mongoose = require('mongoose');

var categorySchema = mongoose.Schema({
    name: { type: String, index: true }
});

module.exports = mongoose.model('Category', categorySchema);
