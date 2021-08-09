function setenv

	if  test -d $argv[1]
        echo Current Environment is $ENVNUM	
	else
        # Set environment
        set -x ENVNUM $argv[1]

		# Switch kubernetes config file
		ktl-configswitchimpl

		# Set DB Env
		e-switchdbimpl
	end
end
