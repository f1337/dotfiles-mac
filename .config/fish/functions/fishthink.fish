function fishthink
	set -l eyes \$ \= x \@ \* 0 \. -
	set i (math (math (random)%8)+1)
	cowthink -e $eyes[$i] -W 80 -f fish $argv
end
