function gitlab-search

# https://docs.gitlab.com/ee/api/search.html
    
    argu s:: scope:: q: query: c: content:: -- $argv | while read -l opt value
        switch $opt
            case -s --scope
                set scope $value
            case -q --query
                set query $value
            case -c --content
                set content_type $value
        end
    end
    
    set -q content_type; or set content_type "json";

    set response (curl -s --header "Private-Token: $GITLAB_PRIVATE_TOKEN" "https://gitlab.verimi.cloud/api/v4/search?scope=$scope&search=$query")
    if [ "$content_type" = "json" ]
        echo $response | jq -r $json_selector
    else
        echo $response
    end
end