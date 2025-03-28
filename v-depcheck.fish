function v-depcheck
    
    # Refresh the suppression file
    pushd $DCHECK_SUPPRESSION_FILE/..
    git pull
    popd

    #Run the dependency check
    ./gradlew dependencyCheckAggregate -PnvdApiKey=$NVD_API_KEY -Danalyzer.ossindex.enabled=false -PcveSuppressionFile=$DCHECK_SUPPRESSION_FILE

end