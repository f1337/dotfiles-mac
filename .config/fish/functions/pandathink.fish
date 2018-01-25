function pandathink
	set -l eyes \$ \= x \@ \* 0 \. -
	set i (random 1 8)
	cowthink -e $eyes[$i] -W 80 -f panda $argv
end
