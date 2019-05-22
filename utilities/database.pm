package utilities::database;
use DBI;

    $myConnection;
    $table_name = 'tableA'; 
    
    sub connect 
    {
        my $class = ref($_[0])|| $_[0];
        my $this ||= {};
        $myConnection = DBI->connect("dbi:mysql:database=user7;host=127.0.0.1;","user7","user7");
        return bless($this, $class);
    }

    sub DESTROY {
        $myConnection->disconnect();
    }

    sub select_query 
    {
        my ($dbh) = $myConnection;
        my $sql = "SELECT *
                    FROM $table_name";
        my $sth = $dbh->prepare($sql);
        
        $sth->execute();
        
        while(my @row = $sth->fetchrow_array()){
            printf("%s\t%s\n",$row[0],$row[1]);
        }       
        $sth->finish();
    }

    sub update_query 
    {
        my ($dbh) = $myConnection;

        my $sql = "UPDATE $table_name
                SET name = ?
            WHERE id = ?";
        
        my $sth = $dbh->prepare($sql);
        
        my $id = 1;
        my $name = "PERL3";

        $sth->bind_param(1,$name);
        $sth->bind_param(2,$id);
        
        $sth->execute();
        
        $sth->finish();
    }
    
    sub insert_query 
    {
        my ($dbh,$id,$name) = @_;
        $dbh = $myConnection;

        my $sql = "INSERT INTO $table_name(id,name)
        VALUES(?,?)";
        
        my $sth = $dbh->prepare($sql);
        
        # bind the corresponding parameter
        $sth->bind_param(1,$id);
        $sth->bind_param(2,$name);
        
        # execute the query
        $sth->execute();
        
        $sth->finish();
    }
    
    sub delete_query 
    {
        my($dbh,$link_id)  = @_;
        $dbh = $myConnection;
        my $sql = "DELETE FROM $table_name WHERE id = ?";
        my $sth = $dbh->prepare($sql);
        $sth->execute($link_id);
        $sth->finish();
    }
1;