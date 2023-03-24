function e-remote-debugimpl
	
	#dependencies
	source (status dirname)"/utils.fish"

	# https://github.com/oh-my-fish/plugin-argu
	argu p: port: n: name: -- $argv | while read -l opt value
        switch $opt
            case -p --port
                set localport $value
			case -n --name
                set name $value
        end
    end

	set -q ENVNUM; or printerror "[ERROR] Environment as not been set." && printerror "Please use `e <envname>` to set an environment" && return;
    set -l pod_name (getpodname $ENVNUM $name)
	set -q localport; or set localport 5005;
	echo Port forwarding on $pod_name in {$ENVNUM} with local port $localport to remote port 5005
	kubectl -n {$ENVNUM} port-forward $pod_name $localport:5005
end
