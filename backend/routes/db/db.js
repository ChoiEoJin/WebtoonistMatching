var mysql = require('mysql');

var con = mysql.createConnection({
    host: "45.119.147.170",
    port:"3306",
    user: "matching",
    password: "matching",
    database:"matching"
  });
  
  con.connect(function(err) {
    if (err) throw err;
    console.log("실서버 커넥트객체1개 만들어두었습니다 생성하였습니다");
  });

  module.exports = con;