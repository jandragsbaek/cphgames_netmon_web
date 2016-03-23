var pg = require('pg');
var conString = 'postgres://cphgames:cphgames@localhost/cphgames';
var client = new pg.Client(conString);


client.connect(function(err){
  if(err){
    return console.log('Could not connect');
  }

  client.query('SELECT * FROM heartbeat', function(err, result){

    console.log(result.rows);

  });
});
