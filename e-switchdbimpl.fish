function e-switchdbimpl
    
    set key (string sub --length 3 $ENVNUM)

    if [ "$ENVNUM" = "devint" ]
		export E_DB_HOST=$VERIMI_STG_DB_IP
        return
	end

    if [ "$key" = "dev" ]
		export E_DB_HOST=$VERIMI_DEV_DB_IP
        return
	end

	if [ "$key" = "uat" ]
		export E_DB_HOST=$VERIMI_STG_DB_IP
        return
	end
end