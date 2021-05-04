const express = require("express");
var app = express(),
    bodyParser = require('body-parser');

const mysql = require('mysql');
var pool  = mysql.createPool({
  connectionLimit : 10,
  host            : 'example.org',
  user            : 'bob',
  password        : 'secret',
  database        : 'my_db'
});
 
pool.query('SELECT 1 + 1 AS solution', function (error, results, fields) {
  if (error) throw error;
  console.log('The solution is: ', results[0].solution);
});

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.get("/", function(request, response) {
	response.send("Hello World!");
});

app.listen(4100, function () {
	console.log("Started application on port %d", 4100);
});