set -g TN_ERROR_COLOR red
set -g TN_WARN_COLOR brcyan
set -f TN_CODE_COLOR C0C0C0
set -f TN_INFO_COLOR brmagenta
set -f TN_SUCCESS_COLOR brgreen

function _print
    set_color $argv[1];
    echo $argv[2]
    set_color normal;
end

function printerror
    _print $TN_ERROR_COLOR $argv;
end

function printwarning
    _print $TN_WARN_COLOR $argv;
end

function printinfo
    _print $TN_INFO_COLOR $argv;
end

function printsuccess
    _print $TN_SUCCESS_COLOR $argv;
end

function printcode
    echo 
    echo -n "     "
    set_color -r $CODE_COLOR;
    echo "$argv[1]"
    echo
    set_color normal;
end