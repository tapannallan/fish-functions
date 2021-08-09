function delombok-file-impl
    java -jar ~/Workspace/Infra/Store/tools/lombok-1.18.18.jar delombok -p $argv[1] > ~/Downloads/Cleanup/delomboked/file.java
    cd ~/Downloads/Cleanup/delomboked
end
