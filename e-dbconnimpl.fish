function e-dbconnimpl

    set localport (eval "echo \$$ENVNUM"_PSQL_PORT)
	echo 1 $ENVNUM
	echo 2 $localport
	echo 3 (getpodname $ENVNUM "postgres")
	kubectl -n $ENVNUM port-forward (getpodname $ENVNUM "postgres") $localport:5432
end