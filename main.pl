use strict;
use DBI;
use utilities::database;

my $db = utilities::database->connect();
$db->update_query();
$db->insert_query(5,"AKULA");
$db->select_query();
print "\n";
$db->delete_query(5);
$db->select_query();

