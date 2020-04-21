function setenv

	if  test -d $argv[1]
        echo Current Environment is $ENVNUM	
	else
        # Set environment
        set -x ENVNUM $argv[1]
        echo $ENVNUM
		# Switch kubernetes config file
		ktl-configswitchimpl
	end
end
