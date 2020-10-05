set ERROR_COLOR red
set WARN_COLOR brcyan
set CODE_COLOR C0C0C0
set INFO_COLOR brmagenta
set SUCCESS_COLOR brgreen

function _print
    set_color $argv[1];
    echo $argv[2]
    set_color normal;
end

function printerror
    _print $ERROR_COLOR $argv;
end

function printwarning
    _print $WARN_COLOR $argv;
end

function printinfo
    _print $INFO_COLOR $argv;
end

function printsuccess
    _print $SUCCESS_COLOR $argv;
end

function printcode
    echo 
    echo -n "     "
    set_color -r $CODE_COLOR;
    echo "$argv[1]"
    echo
    set_color normal;
end