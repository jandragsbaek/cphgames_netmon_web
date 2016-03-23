var snmp = require("snmp-native");
var session = new snmp.Session({community: 'evilpals', family: 'udp4'});
var oid = [1,3,6,1,2,1,1,3,0];

var pg = require('pg');
var conString = 'postgres://cphgames:cphgames@localhost/cphgames';
var client = new pg.Client(conString);

/* ip = 10.0.0.111 */

// 1,3,6,1,2,1,1,3,0  = Uptime in 1/100th seconds
// 1.3.6.1.2.1.31.1.1.1.10.<portnum> = outbound traffic (64bit)
// 1.3.6.1.2.1.31.1.1.1.6.<portnum> = inbound traffic (64bit)
//
// 10.0.0.100 - 10.0.0.198


var cnt = 0;
var max = 0;


client.connect(function(err)
{
  if(err)
  {
    return console.log('Could not connect');
  }

  client.query('SELECT * FROM switches', function(err, result)
  {
    max = result.rows.length;
    result.rows.forEach(function(row)
    {
      (function(host)
      {
        session.get({oid: oid, host: host}, function(err, vbs)
        {
          if(err)
          {
            client.query("UPDATE switches SET alive=false, uptime=0, updated_at=NOW() WHERE ip='" + host  +"'", function(err, res)
            {
              console.log(host + " is not reachable!");
              close_check();
            });
          } 
          else 
          {
            client.query("UPDATE switches SET alive=true, updated_at=NOW(), uptime="+ vbs[0].value +" WHERE ip='" + host  +"'", function(err, res){
              console.log(host + " is up! Up for " + Math.round(vbs[0].value/6000/60) + " hours!");
              close_check();
            });
            
          }


        })
      }(row.ip));
    })
  });
});


function close_check(){
  if(++cnt == max){
    session.close();
    client.end();;
  }
}
