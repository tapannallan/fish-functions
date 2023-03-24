function e-edit-env

    set short_key (string sub --length 3 $ENVNUM)
	set long_key (string sub --length 8 $ENVNUM)

    if [ "$long_key" = "devint" -o "$short_key" = "dev" ]
		code ~/Workspace/Verimi-Main/environments
        return
	end

    if [ "$short_key" = "uat" ]
		code ~/Workspace/Verimi-Main/environments-prod
        return
	end

	if [ "$long_key" = "waas-dev" ]
		code ~/Workspace/Verimi-Main/waas-dev
        return
	end

	if [ "$long_key" = "galactus" ]
		code ~/Workspace/Verimi-Main/galactus
        return
	end
end