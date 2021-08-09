function getpodname
	if [ "$argv[1]" = "--help" ]
     echo "Usage: $argv[0] <namespace> <service-name>"
     return
    end
	kubectl -n $argv[1] get pods --request-timeout=10s | grep -oEi ".*$argv[2][a-zA-Z0-9\-]*"
end