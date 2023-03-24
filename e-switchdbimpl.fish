function e-switchdbimpl
    
    set short_key (string sub --length 3 $ENVNUM)
	set long_key (string sub --length 8 $ENVNUM)

    if [ "$ENVNUM" = "devint" ]
		export E_DB_HOST=$VERIMI_STG_DB_IP
        return
	end

    if [ "$short_key" = "dev" ]
		export E_DB_HOST=$VERIMI_DEV_DB_IP
        return
	end

	if [ "$short_key" = "uat" ]
		export E_DB_HOST=$VERIMI_STG_DB_IP
        return
	end

	if [ "$long_key" = "waas-dev" -o "$long_key" = "galactus" ]

		#clear prev port forwards

		#port forwar
		export E_DB_HOST=$VERIMI_STG_DB_IP
        return
	end

end