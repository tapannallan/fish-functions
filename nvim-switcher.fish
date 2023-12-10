function nvim-switcher -d "Invoke Nvim Config Switcher"

    set -l argv_count (count $argv)
    set -l arg_search_cmds switch s delete d

    if contains $argv[1] $arg_search_cmds;
        if [ $argv_count -lt 2 ];
            set -a argv (ls ~/.config/nvim-switcher | fzf)
        end
    end

    #TODO Add Config Switch for locations
    # ~/.local/state/nvim
    # ~/.cache/nvim

    if [ \( $argv[1] = "create" -o $argv[1] = "c" \) -a $argv_count -lt 2 ];
        echo [ERROR] Missing Config name to create
        return
    end

    set -l config_command $argv[1]
    set -l config_identifier $argv[2]

    if [ $config_command = "create" -o $config_command = "c" ];
        mkdir -p ~/.config/nvim-switcher/$config_identifier
        mkdir -p ~/.local/share/nvim-switcher/$config_identifier
        mkdir -p ~/.local/state/nvim-switcher/$config_identifier
        mkdir -p ~/.cache/nvim-switcher/$config_identifier

        rm ~/.config/nvim > /dev/null 2>&1
        rm ~/.local/share/nvim > /dev/null 2>&1
        rm ~/.local/state/nvim > /dev/null 2>&1
        rm ~/.cache/nvim > /dev/null 2>&1

        ln -s -f ~/.config/nvim-switcher/$config_identifier ~/.config/nvim
        ln -s -f ~/.local/share/nvim-switcher/$config_identifier ~/.local/share/nvim
        ln -s -f ~/.local/state/nvim-switcher/$config_identifier ~/.local/state/nvim
        ln -s -f ~/.cache/nvim-switcher/$config_identifier ~/.cache/nvim

    else if [ $config_command = "delete" -o $config_command = "d"  ];
        echo deleting $config_identifier
        rm ~/.config/nvim > /dev/null 2>&1
        rm ~/.local/share/nvim > /dev/null 2>&1

        rm -rf ~/.config/nvim-switcher/$config_identifier
        rm -rf ~/.local/share/nvim-switcher/$config_identifier
        echo Done!
    else if [ $config_command = "switch" -o $config_command = "s"  ];
        echo switching to $config_identifier
        rm ~/.config/nvim > /dev/null 2>&1
        rm ~/.local/share/nvim > /dev/null 2>&1

        ln -s -f ~/.config/nvim-switcher/$config_identifier ~/.config/nvim
        ln -s -f ~/.local/share/nvim-switcher/$config_identifier ~/.local/share/nvim
    else if [ $config_command = "reset" -o $config_command = "r"  ];
        rm ~/.config/nvim > /dev/null 2>&1
        rm ~/.local/share/nvim > /dev/null 2>&1
        rm ~/.local/state/nvim > /dev/null 2>&1
        rm ~/.cache/nvim > /dev/null 2>&1
        echo nvim configuration has been reset to default nvim
    end
end