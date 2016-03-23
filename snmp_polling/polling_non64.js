var snmp = require("snmp-native");
var session = new snmp.Session({community: 'evilpals', family: 'udp4'});
var oids = [[1,3,6,1,2,1,2,2,1,16,24], [1,3,6,1,2,1,2,2,1,10,24]]

var pg = require('pg');
var conString = 'postgres://cphgames:cphgames@localhost/cphgames';
var client = new pg.Client(conString);
/* ip = 10.0.0.111 */

// 1,3,6,1,2,1,1,3,0  = Uptime
// 1.3.6.1.2.1.31.1.1.1.10.<portnum> = outbound traffic (64bit)
// 1.3.6.1.2.1.31.1.1.1.6.<portnum> = inbound traffic (64bit)
//
// 10.0.0.100 - 10.0.0.198
//

var cnt = 0;
var max = 0;

client.connect(function(err)
{
  if(err)
  {
    return console.log('Could not connect');
  }

  client.query('SELECT * FROM switches WHERE alive=TRUE AND bigint=FALSE', function(err, result)
  {
    max = result.rows.length * 2;
    result.rows.forEach(function(row)
    {
      (function(host, id)
      {
        session.getAll({oids: oids, host: host}, function(err, vbs)
        {
          if(!err)
          {
            vbs.forEach(function(vb) {

              var oid_string = vb.oid.toString();
              var direction = 'out';
              if(oid_string.substring(oid_string.length - 4) === '0,24'){
                direction = 'in';
              }

              if(vb.value === 'noSuchInstance'){
                console.log(host + ' returns noSuchInstance');
                close_check();
              } else {
                client.query("INSERT INTO readings (bytes, switch_id, port, direction, updated_at, created_at) VALUES ("+vb.value+","+id+",24,'"+direction+"', NOW(), NOW())", function(err, res){
                  if(err) { console.log(err) }
                  close_check();
                  console.log('Logged '+vb.value+' bytes for port 24 on '+host);
                })
              }
            }) 
          }
        })
      }(row.ip, row.id));
    })
  });
});

function close_check(){
  if(++cnt == max){
    session.close();
    client.end();;
  }
}
