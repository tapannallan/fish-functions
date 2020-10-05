function tttt
    set files []  
    cat /Users/tapannallan/Downloads/Cleanup/completions.txt | while read -l foo

        if [ -d $foo ]
            for ff in (ls $foo)
                echo $foo\\$ff \n
            end
        end
    end
end