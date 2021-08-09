function gitlab-get

    argu c:: content:: e: endpoint: f:: filename::  s:: selector:: -- $argv | while read -l opt value
        switch $opt
            case -f --filename
                set filename $value
            case -c --content
                set content_type $value
            case -s --selector
                set json_selector $value
            case -e --endpoint
                set endpoint $value
        end
    end
    set -q location_prop; or set location_prop "";
    if [ "$content_type" = "file" ]
        
        if test -z "$filename"
            printerror "gitlab-get: ERROR: Filename should be provided when content type is file"
            return
        end
        set location_prop "-o$filename"
    end
    set -q content_type; or set content_type "json";

    echo "curl $location_prop -s --header \"Private-Token: $GITLAB_PRIVATE_TOKEN\" https://gitlab.verimi.cloud/api/v4$endpoint?page=1&per_page=5"
    return
    #set response (curl $location_prop -s --header "Private-Token: $GITLAB_PRIVATE_TOKEN" https://gitlab.verimi.cloud/api/v4$endpoint?page\=1&per_page\=5)

    

    if [ "$content_type" = "json" ]
        echo $response | jq -r $json_selector
    else if [ "$content_type" = "file" ]
        echo file has been stored to $filename
    else
        echo $response
    end
end