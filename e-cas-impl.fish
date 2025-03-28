function e-cas-impl
    cd /Users/tapannallan/Workspace/Verimi-Other/cas-signing
    source venv/bin/activate.fish
    python3 sign_updated.py $ENVNAME
end