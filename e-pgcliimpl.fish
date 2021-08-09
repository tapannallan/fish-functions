function e-pgcliimpl

    set -l dbname_offset ""
    set -l query ""

    #argu d:: content:: e: endpoint: f:: filename::  s:: selector:: -- $argv | while read -l opt value
    argu h hydra q:: query:: a auto -- $argv | while read -l opt value
            switch $opt
                case -h --hydra
                    set dbname_offset _hydra
                case -q --query
                    set query $value
                case -a --auto
                    set autoexecute true
            end
    end

    set -l dbname (string lower $ENVNUM$dbname_offset)

    # Order of the If conditions is important. 
    # Auto has to run before the query test
    
    # If Auto
    if [ "$autoexecute" = "true" ];
        echo run fzf or sk to fetch a query
        set query "select email,verified from contact.email"
    end 

    #If no sql query is passed
    if test -z "$query"; 
        echo connecting to $dbname database
        pgcli "postgresql://postgres:postgres@$E_DB_HOST:5432/"(string lower $ENVNUM$dbname_offset)
        return
    end

    #Sql Query present
    echo Executing query on $dbname database
    psql -h $E_DB_HOST -p 5432 -U postgres -d $dbname -c $query
end