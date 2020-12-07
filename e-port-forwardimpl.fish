function e-port-forwardimpl
    set -l pod_name (getpodname $ENVNUM $argv[1])
    set -l ports 5005
    set -l argv_count (count $argv)
    
    if [ $argv_count -eq 2 ];
        set ports $argv[2]
    end
	
	echo Port forwarding $ports on $pod_name in $ENVNUM
	e-ktlimpl "-n $ENVNUM port-forward $pod_name $ports"
end