function gitlab-post
    argu c:: contenttype:: p:: payload:: e: endpoint:  s:: selector:: -- $argv | while read -l opt value
        switch $opt
            case -c --contenttype
                set content_type $value
            case -s --selector
                set json_selector $value
            case -p --payload
                set payload $value
            case -e --endpoint
                set endpoint $value
        end
    end
    set -q content_type; or set content_type "json";
    set response (curl -s -X POST --header "Private-Token: $GITLAB_PRIVATE_TOKEN" --header "Content-Type: application/json" -d "$payload" https://gitlab.verimi.cloud/api/v4$endpoint)
    if [ "$content_type" = "json" ]
        echo $response | jq -r $json_selector
    else
        echo $response
    end
end