function e-pgcliimpl

if test -z "$argv[1]"; set argv[1] postgres; end
echo connecting to $ENVNUM $argv[1] database

if [ "$ENVNUM" = "perf" ]
    set host 10.22.1.100
else
    set host localhost
end

set dbport (eval "echo \$$ENVNUM"_PSQL_PORT)
pgcli "postgresql://postgres:postgres@$host:$dbport/$argv[1]"
end