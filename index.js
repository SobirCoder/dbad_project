const express = require("express");
var app = express(),
    bodyParser = require('body-parser');

const mysql = require('mysql');
var pool  = mysql.createPool({
  connectionLimit : 10,
  host            : 'localhost',
  user            : 'techiela_team27',
  password        : 'techiela_team27',
  database        : 'techiela_team27'
});

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.get('/api/countries', (req, res) => {
  pool.query('call proc_get_countries(null)', function (error, results, fields) {
    if (error) throw error;
    console.log('result: ', results);
    res.json(results);
  });
});

app.get("/", function(request, response) {
	response.send("Hello World!");
});

app.listen(4100, function () {
	console.log("Started application on port %d", 4100);
});