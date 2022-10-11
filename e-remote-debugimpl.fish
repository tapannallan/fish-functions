function e-remote-debugimpl

    set -l pod_name (getpodname $ENVNUM $argv)
    set -l localport 5005
	if (( ${+2} )); then
		localport $2	
	end	
	echo Port forwarding on $pod_name in ${ENVNUM} with local port $localport to remote port 5005
	kubectl -n ${ENVNUM} port-forward $pod_name $localport:5005
    kubectl -n $ENVNUM 
end
