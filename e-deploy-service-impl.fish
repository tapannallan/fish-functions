function e-deploy-service-impl
    set -l working_tree_status (git status -s)
    test -z "$working_tree_status" || printwarning 'WARNING: Working tree is not clean.'

    set -l git_branch (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
    set -l service_name (basename $PWD)

    #Check if it has upstream branch
    git status -sb | grep ...origin > /dev/null
    if [ $status -ne 0 ]
        printerror "ERROR: Branch $git_branch has no remote tracking branch."
        echo Push your branch to remote or set tracking by running the command
        printcode "git branch --set-upstream-to=origin/$git_branch $git_branch"
        echo Stopping...
        return
    end

    #Check if all commits are pushed
    git status -sb | grep "\[ahead" > /dev/null
    if [ $status -eq 0 ]
        echo -n "Pushing commits to remote..."
        git push origin $git_branch > /dev/null 2>&1
        echo done
    end

    echo Deploying $git_branch of $service_name to $ENVNUM

    #get project id
    set -l project_id (gitlab-get -e /groups/verimi-platform -s ".projects[] | select(.name==\"$service_name\").id")

    #Fetch commit_id
    set -l commit_id (git rev-parse HEAD)
    echo deploying commit $commit_id

    #get latest active pipelines of this branch and commitid
    set -l pipeline (gitlab-get -e /projects/$project_id/pipelines -s "[.[] | select(.ref==\"$git_branch\" and .sha == \"$commit_id\")] | max_by(.id)")
    set -l pipeline_id (echo $pipeline | jq -r '.id')

    #get docker job for this pipeline
    set job (gitlab-get -e /projects/$project_id/pipelines/$pipeline_id/jobs -s '[.[] | select(.stage == "package")] | sort_by(.created_at)[-1]')
    set job_status (echo $job | jq -r '.status')
    echo Initial Job status is $job_status
    set time_out_count 120
    echo -n "Checking if docker image build job is finished.."

    #TODO: This while expression fails sporadically, needs to be fixed
    while test $time_out_count -gt 0 -a \( $job_status = "created" -o $job_status = "pending" -o $job_status = "running" \);
        echo -n .
        sleep 5;
        set job (gitlab-get -e /projects/$project_id/pipelines/$pipeline_id/jobs -s '[.[] | select(.stage == "package")] | sort_by(.created_at)[-1]')
        set job_status (echo $job | jq -r '.status')
        set time_out_count (math $time_out_count - 1)
    end

    if [ $time_out_count -le 0 ]
        printerror ERROR: Timed out waiting for the job to end. Exiting...
        return
    else
        #docker job is finished
        echo done
    end

    if [ $job_status = "success" ];

        set -l job_id (echo $job | jq -r '.id')
        echo Fetching dockerimage file
        gitlab-get -e /projects/$project_id/jobs/$job_id/artifacts/docker-image.txt -c file -f dockerimage.txt > /dev/null
        set -l image_tag_tokens (cat dockerimage.txt | string match -r "registry.gitlab.verimi.cloud/verimi-platform/.*/(.*)")
        set -l image_tag $image_tag_tokens[2]
        rm dockerimage.txt

        echo Image tag is $image_tag 

        # checkout branch in env repo
        pushd $ENVIRONMENTS_REPO
        echo stashing environments repo \n
        git stash > /dev/null
        git checkout -- . > /dev/null

        echo checkout $ENVNUM branch in environments repo \n 
        git checkout $ENVNUM > /dev/null

        echo Pulling in latest changes \n
        git pull > /dev/null 

        #change the service file
        sed -e "s|\(  tag:\).*|\1 $image_tag|;s|\(\ttag:\).*|\1 $image_tag|" config/service/$service_name.yaml > config/service/updated_$service_name.yaml
        rm config/service/$service_name.yaml
        mv config/service/updated_$service_name.yaml config/service/$service_name.yaml
        
        #if config map change is required
        # TODO: Open configmap in a editor if the configmap switch is included

        git commit -a -m "auto-deploying $git_branch"
        git push origin $ENVNUM

        popd
        printsuccess DEPLOYED
    else
        printerror "job was not successful. exiting..."
        return
    end
end
