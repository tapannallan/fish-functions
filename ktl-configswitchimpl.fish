	function ktl-configswitchimpl
	set short_key (string sub --length 3 $ENVNUM)
	set long_key (string sub --length 8 $ENVNUM)

	if [ "$long_key" = "devint" -o "$short_key" = "uat" ]
		cp ~/.kube/uat-config ~/.kube/config
		echo kube config changed to uat
		echo Environment changed to $ENVNUM
        return
	end

	if [ "$short_key" = "dev" ]
		cp ~/.kube/dev-config ~/.kube/config
		echo kube config changed to dev
		echo Environment changed to $ENVNUM
        return
	end

	if [ "$long_key" = "perf" ]
		cp ~/.kube/perf-config ~/.kube/config
		echo kube config changed to perf
		echo Environment changed to $ENVNUM
		return
	end

	if [ "$long_key" = "waas-dev" -o "$long_key" = "galactus" ]
		cp ~/.kube/waas-config ~/.kube/config
		echo kube config changed to the galactus environment
		echo Environment changed to $ENVNUM
		return
	end

	if [ "$ENVNUM" = "verimi-vau-interim1" ]
		cp ~/.kube/vau-interim-config ~/.kube/config
		echo kube config changed to vau interim
		echo Environment changed to $ENVNUM
        return
	end

	echo $ENVNUM is not a valid environment. Switching to waas-dev1
	export ENVNUM=waas-dev1
	ktl-configswitchimpl
end