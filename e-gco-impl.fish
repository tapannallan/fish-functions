function e-gco-impl

    # Fetch current repo and map to service

    # fetch commit deployed for service in current env

    echo Checking out $commit_id in $service_name for $ENVNUM
    git checkout $commit_id
end