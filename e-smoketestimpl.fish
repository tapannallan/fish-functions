function e-smoketestimpl
    
    #get project id
    set project_id (gitlab-get -e /groups/verimi-platform -s ".projects[] | select(.name==\"system-test\").id")

    #Start Smoke test
    set pipeline_id (gitlab-post -c json -s ".id" -e "/projects/$project_id/pipeline" -p '{"ref": "master", "variables" : [{ "key": "TEST_ENV", "variable_type": "env_var", "secret_value": "'$ENVNUM'" },{ "key": "ACTION", "variable_type": "env_var", "secret_value": "smoke_test" }]}')
    if [ "$key" = "" ]
		echo Could not start pipeline for smoke test.
        return
	end
    echo "Running smoke test pipeline at https://gitlab.verimi.cloud/verimi-platform/system-test/pipelines/$pipeline_id"
    

    #Get Frontend smoke test job
    set job (gitlab-get -e /projects/$project_id/pipelines/$pipeline_id/jobs -s '.[] | select(.name == "dev_fe_smoke_test")')
    set job_id (echo $job | jq -r '.id')
    set job_status (echo $job | jq -r '.status')
    echo $job_status

    #Wait till job finishes
    set time_out_count 500
    while [ $time_out_count -gt 0 -a \( $job_status = "created" -o $job_status = "running" -o $job_status = "pending" \) ]
        echo waiting for smoke test to finish
        sleep 10;
        set time_out_count (math $time_out_count - 1)
        set job_status (gitlab-get -e /projects/$project_id/jobs/$job_id -s '.status')
        echo current status is $job_status
    end

    #Download zip
    echo Downloading artifacts zip
    mkdir -p -- ~/Downloads/Cleanup/"$ENVNUM-$job_id"
    cd ~/Downloads/Cleanup/"$ENVNUM-$job_id"
    gitlab-get -c file -f report.zip -e /projects/$project_id/jobs/$job_id/artifacts

    #Say/Notify smoke test finished

    #open test results
    open .
end