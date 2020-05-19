var express = require('express');
var bodyParser = require("body-parser");
var mysql = require('mysql');
var app = express();
app.set("view engine", "ejs");
app.use(bodyParser.urlencoded({extended: true}));
app.use(express.static(__dirname + "/public"));

var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',     // your root username
  database : 'join_us',   // the name of your db
  password : 'Chunglau96!'
});
 
app.get("/", function(req, res){
 var q = "SELECT COUNT(*) AS count FROM users";
 connection.query(q, function(err, results){
 if(err) throw err;
 var count = results[0].count;
 res.render("home", {count: count});
 });
});

app.listen(8080, function() {
 console.log('App listening on port 8080!');
});

app.post('/register', function(req,res){
 var person = {email: req.body.email};
 connection.query('INSERT INTO users SET ?', person, function(err, result) {
 console.log(err);
 console.log(result);
 res.redirect("/");
 });
});


app.get("/joke", function(req, res){
 var joke = "What do you call a dog that does magic tricks? A labracadabrador.";
 res.send(joke);
});

app.get("/random_num", function(req, res){
 var num = Math.floor((Math.random() * 10) + 1);
 res.send("Your lucky number is " + num);
});