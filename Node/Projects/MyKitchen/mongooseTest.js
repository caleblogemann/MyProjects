var mongoose = require('mongoose');
mongoose.connect('mongodb://localhost/test');

var db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', function(callback) {
    var kittySchema = mongoose.Schema({
            name: String
    });
    kittySchema.methods.speak = function () {
        var greeting = this.name
            ? "Meow name is " + this.name
            : "I don't have a name"
            console.log(greeting);
    };

    var Kitten = mongoose.model('Kitten', kittySchema);
    var silence = new Kitten({ name: 'Silence'});
    silence.speak();

    silence.save(function(err, kitten){
        if(err){
            console.log(err);
        }
        kitten.speak();
    });

    var fluffy = new Kitten({ name: 'Fluffy'});
    fluffy.save(function(err, kitten){
        if(err){
            return console.error(err);
        };
        kitten.speak();
        Kitten.find(function(err, kittens){
            if (err){
                return console.error(err);
            };
            console.log(kittens)
            db.close();
        });
    });

});
