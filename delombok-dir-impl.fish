function delombok-dir-impl
    java -jar ~/Workspace/Infra/Store/tools/lombok-1.18.18.jar delombok $argv[1] -d ~/Downloads/Cleanup/delomboked
    cd ~/Downloads/Cleanup/delomboked
end
