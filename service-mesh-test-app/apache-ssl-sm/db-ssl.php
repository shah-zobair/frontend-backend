<?php
try{$dbuser = 'shah';
$dbpass = 'shah123';
$host = 'backend';
$port = '5432';
$dbname = 'testing';
$sslcert = '/tmp/certs/client-cert.pem';
$sslkey = '/tmp/postgresql-user.key';
$sslrootcert = '/tmp/certs/root.crt';

$conn = new PDO("pgsql:host=$host;dbname=$dbname;port=$port;sslmode=require;sslcert=$sslcert;sslkey=$sslkey;sslrootcert=$sslrootcert", $dbuser, $dbpass);

}
catch (PDOException $e)
{
echo "Error : " . $e->getMessage() . "<br/>";
die();
} 

$sql = 'SELECT * FROM dummy';

foreach ($conn->query($sql) as $row) {
        print $row['name'] . "\t";
        print $row['id'] . "\n";
    }

print "<br><br>";
print "Displaying encrypted entries from testuserscards table<br>";

$privkey = file_get_contents("/tmp/CERT/secret-pgp.key");
$sql = "SELECT username, pgp_pub_decrypt(cc, keys.privkey) As ccdecrypt
FROM testuserscards
    CROSS JOIN
    (SELECT dearmor('$privkey') As privkey) As keys;";

foreach ($conn->query($sql) as $row) {
        print $row['username'] . "\t";
        print $row['ccdecrypt'] . "<br>";
}

?>
