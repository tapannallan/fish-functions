function e-ktlimpl

    set -l key (string sub --length 3 $ENVNUM)
    set -l longkey (string sub --length 4 $ENVNUM)
    set -l config "~/.kube/dev-config" 

	if [ "$ENVNUM" = "devint" ];
		set config "$HOME/.kube/uat-config"
    else if [ "$key" = "dev" ];
        set config "$HOME/.kube/dev-config"
    else if [ "$key" = "uat" ];
        set config "$HOME/.kube/uat-config"
    else if [ "$longkey" = "perf" ];
        set config "$HOME/.kube/perf-config"
    else
        set config "$HOME/.kube/dev-config"
    end
    eval "kubectl --kubeconfig $config $argv" 
end