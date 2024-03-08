echo -ne '\e[0mnormal\e[0m\t\t\t'
echo -e '\e[7m reverse \e[0m'

echo -ne '\e[2mdim\e[0m\t\t\t'
echo -e '\e[7;2m reverse dim \e[0m'

echo -ne '\e[1mbold\e[0m\t\t\t'
echo -e '\e[7;1m reverse bold \e[0m'

echo -ne '\e[3mitalic\e[0m\t\t\t'
echo -e '\e[7;3m reverse italic \e[0m'

echo -ne '\e[2;3mdim italic\e[0m\t\t'
echo -e '\e[7;2;3m reverse dim italic \e[0m'

echo -ne '\e[1;3mbold italic\e[0m\t\t'
echo -e '\e[7;1;3m reverse bold italic \e[0m'

echo
echo -e '\e[4munderline\e[0m'
echo -e '\e[3;4mitalic underline\e[0m'
echo -e '\e[4:1mthis is also underline \e[0m'
echo -e '\e[21mdouble underline \e[0m'
echo -e '\e[4:2mthis is also double underline \e[0m'
echo -e '\e[4:3mcurly underline \e[0m'
echo -e '\e[21m\e[58;5;42m256-color underline \e[0m'
echo -e '\e[4:3m\e[58;2;240;143;104mtruecolor underline  (*)\e[0m'
echo -e "\e[58:2::255:0:0m\e[4:1msingle underline \e[0m"
echo -e "\e[4:2mdouble underline \e[58:2::255:0:0m and with color\e[0m"
echo -e "\e[4:3mcurly underline \e[58:2::255:0:0m and with color\e[0m"
echo -e "\e[4:4mdotted underline \e[58:2::255:0:0m and with color\e[0m"
echo -e "\e[4:5mdashed underline \e[58:2::255:0:0m and with color\e[0m"

echo
echo -e '\e[5mblink \e[0m'
echo -e '\e[8minvisible\e[0m <- invisible (but copy-pasteable)'
echo -e '\e[9mstrikethrough\e[0m'
echo -e '\e[53moverline \e[0m'
echo -e '\e[51mframed \e[0m'
echo -e '\e[52mencircled \e[0m'

echo -e '\e[31mred\e[0m'
echo -e '\e[91mbright red\e[0m'
echo -e '\e[38:5:42m256-color, de jure standard (ITU-T T.416)\e[0m'
echo -e '\e[38;5;42m256-color, de facto standard (commonly used)\e[0m'
echo -e '\e[38:2::240:143:104mtruecolor, de jure standard (ITU-T T.416) \e[0m'
echo -e '\e[38;2;240;143;104mtruecolor, de facto standard (commonly used)\e[0m'

echo -e '\e[46mcyan background\e[0m'
echo -e '\e[106mbright cyan background\e[0m'
echo -e '\e[48:5:42m256-color background, de jure standard (ITU-T T.416)\e[0m'
echo -e '\e[48;5;42m256-color background, de facto standard (commonly used)\e[0m'
echo -e '\e[48:2::240:143:104mtruecolor background, de jure standard (ITU-T T.416) \e[0m'
echo -e '\e[48:2:240:143:104mtruecolor background, rarely used incorrect format (might be removed at some point)\e[0m'
echo -e '\e[48;2;240;143;104mtruecolor background, de facto standard (commonly used)\e[0m'

echo
echo "Emoji: 🚀 💩 😁 🍖 🔥 🔷 ❤️ "

echo
echo "Ligatures:"
echo "-<< -< -<- <-- <--- <<- <- -> ->> --> ---> ->- >- >>- <-> <--> <---> <----> <!--"
echo "=<< =< =<= <== <=== <<= <= => =>> ==> ===> =>= >= >>= <=> <==> <===> <====> <!---"
echo "[| |] {| |} <=< >=> <~~ <~ ~> ~~> :: ::: \/ /\ == != /= ~= <> === !== =/= =!= :>"
echo ":= :- :+ <* <*> *> <| <|> |> <. <.> .> +: -: =: <***> __ (* comm *) ++ +++ |- -|"

echo
echo 24-bit colors:

# This file was originally taken from iterm2 https://github.com/gnachman/iTerm2/blob/master/tests/24-bit-color.sh
#
#   This file echoes a bunch of 24-bit color codes
#   to the terminal to demonstrate its functionality.
#   The foreground escape sequence is ^[38;2;<r>;<g>;<b>m
#   The background escape sequence is ^[48;2;<r>;<g>;<b>m
#   <r> <g> <b> range from 0 to 255 inclusive.
#   The escape sequence ^[0m returns output to default

setBackgroundColor() {
	printf '\x1b[48;2;%s;%s;%sm' $1 $2 $3
}

resetOutput() {
	echo -en "\x1b[0m\n"
}

# Gives a color $1/255 % along HSV
# Who knows what happens when $1 is outside 0-255
# Echoes "$red $green $blue" where
# $red $green and $blue are integers
# ranging between 0 and 255 inclusive
rainbowColor() {
	let h=$1/43
	let f=$1-43*$h
	let t=$f*255/43
	let q=255-t

	if [ $h -eq 0 ]; then
		echo "255 $t 0"
	elif [ $h -eq 1 ]; then
		echo "$q 255 0"
	elif [ $h -eq 2 ]; then
		echo "0 255 $t"
	elif [ $h -eq 3 ]; then
		echo "0 $q 255"
	elif [ $h -eq 4 ]; then
		echo "$t 0 255"
	elif [ $h -eq 5 ]; then
		echo "255 0 $q"
	else
		# execution should never reach here
		echo "0 0 0"
	fi
}

for i in $(seq 0 127); do
	setBackgroundColor $i 0 0
	echo -en " "
done
resetOutput
for i in $(seq 255 -1 128); do
	setBackgroundColor $i 0 0
	echo -en " "
done
resetOutput

for i in $(seq 0 127); do
	setBackgroundColor 0 $i 0
	echo -n " "
done
resetOutput
for i in $(seq 255 -1 128); do
	setBackgroundColor 0 $i 0
	echo -n " "
done
resetOutput

for i in $(seq 0 127); do
	setBackgroundColor 0 0 $i
	echo -n " "
done
resetOutput
for i in $(seq 255 -1 128); do
	setBackgroundColor 0 0 $i
	echo -n " "
done
resetOutput

for i in $(seq 0 127); do
	setBackgroundColor $(rainbowColor $i)
	echo -n " "
done
resetOutput
for i in $(seq 255 -1 128); do
	setBackgroundColor $(rainbowColor $i)
	echo -n " "
done
resetOutput
