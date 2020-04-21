function gitlab-get
    curl -s --header "Private-Token: Qu2RdMqVsArS3QiJcmi6" https://gitlab.verimi.cloud/api/v4$argv[1] | jq -r $argv[2] 
end