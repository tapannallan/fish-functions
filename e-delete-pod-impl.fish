function e-delete-pod-impl
set -l pod_name (getpodname $ENVNUM $argv[1])
echo Deleting $pod_name in $ENVNUM
e-ktlimpl "-n $ENVNUM delete pods $pod_name --grace-period=0 --force"

end