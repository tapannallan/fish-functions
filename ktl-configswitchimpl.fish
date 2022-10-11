	function ktl-configswitchimpl
	set key (string sub --length 3 $ENVNUM)

	if [ "$ENVNUM" = "devint" ]
		cp ~/.kube/uat-config ~/.kube/config
		echo kube config changed to uat
		echo Environment changed to $ENVNUM
        return
	end

	if [ "$key" = "dev" ]
		cp ~/.kube/dev-config ~/.kube/config
		echo kube config changed to dev
		echo Environment changed to $ENVNUM
        return
	end

	if [ "$key" = "uat" ]
		cp ~/.kube/uat-config ~/.kube/config
		echo kube config changed to uat
		echo Environment changed to $ENVNUM
		return
	end

	set key (string sub --length 4 $ENVNUM)
	if [ "$key" = "perf" ]
		cp ~/.kube/perf-config ~/.kube/config
		echo kube config changed to perf
		echo Environment changed to $ENVNUM
		return
	end

	if [ "$key" = "waas" ]
		cp ~/.kube/gematik-config ~/.kube/config
		echo kube config changed to the galactus environment
		echo Environment changed to $ENVNUM
		return
	end

	echo $ENVNUM is not a valid environment. Switching to dev1
	export ENVNUM=dev1
	ktl-configswitchimpl
end