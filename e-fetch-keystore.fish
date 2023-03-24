function e-fetch-keystore
    argu c:: content:: e: endpoint: f:: filename::  s:: secret:: -- $argv | while read -l opt value
        switch $opt
            case -f --filename
                set filename $value
            case -c --content
                set content_type $value
            case -s --secret
                set secret_name $value
            case -e --endpoint
                set endpoint $value
        end
    end
    set -q location_prop; or set location_prop "";
    set -l pod_name (getpodname $ENVNUM $argv[1])
    set -l ports 5005
    set -l argv_count (count $argv)


    echo Port forwarding $ports on $pod_name in $ENVNUM
    e-ktlimpl "-n $ENVNUM port-forward $pod_name $ports"

    kubectl -n waas-dev1 get secret authorization -o jsonpath={.data} | cut -d":" -f2 | cut -d"\"" -f2
end