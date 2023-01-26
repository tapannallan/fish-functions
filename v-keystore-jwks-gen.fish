function v-keystore-jwks-gen

    #cleanup
    set -x KEYS_PATH $STORE_HOME/verimi/keystore
    rm -rf $KEYS_PATH
    mkdir -p  $KEYS_PATH

    set -l STOREPASS (cat $STORE_HOME/verimi/devkeystorepass.txt)

    #access-token-keys
    keytool -list -storepass $STOREPASS -keystore $VERIMI_KEYSTORE | grep PrivateKeyEntry | grep access | cut -d',' -f1 | while read -la keyalias; 
        set -l algidentifier (echo $keyalias | cut -d'-' -f4)
        java -jar $TOOLS_HOME/get-jwk.jar -alias $keyalias -jksPath $VERIMI_KEYSTORE -password $STOREPASS -alg $algidentifier -type private > "$KEYS_PATH/$keyalias.priv.jwk"
        java -jar $TOOLS_HOME/get-jwk.jar -alias $keyalias -jksPath $VERIMI_KEYSTORE -password $STOREPASS -alg $algidentifier -type public > "$KEYS_PATH/$keyalias.pub.jwk"
    end

    #federation signing key
    java -jar $TOOLS_HOME/get-jwk.jar -alias "federation-signing-key" -jksPath $VERIMI_KEYSTORE -password $STOREPASS -alg es256 -type private > "$KEYS_PATH/federation-signing-key-es256.priv.jwk"
    java -jar $TOOLS_HOME/get-jwk.jar -alias "federation-signing-key" -jksPath $VERIMI_KEYSTORE -password $STOREPASS -alg es256 -type public > "$KEYS_PATH/federation-signing-key-es256.pub.jwk"
end