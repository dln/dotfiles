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
echo "Nerdfonts:    󱓼 󱓺 󱓻            󱠇 󰲬  󰍎  󰬟  "
echo "             󱄅 󰣇       "

echo
echo "Geometrical:"
echo -e '◆ ◇ ◈ ● ○ ◉ ◎ ◍ ◌'
echo -e '■ □ ▢ ▣ ▤ ▥ ▦ ▧ ▨ ▩'
echo -e '◧ ◨ ◩ ◪ ◫ ◬ ◭ ◮ △ ▲ ▱ ▰ ▽ ▼ ▾ ▿'
echo -e '◠ ◡ ◢ ◣ ◤ ◥ ◦ ◧ ◨ ◩ ◪ ◫ ◬ ◭ ◮ ◯ ◰ ◱ ◲ ◳ ◴ ◵ ◶ ◷ ◸ ◹ ◺ ◻ ◼ ◽ ◾ ◿'

echo "Arrows:"
echo -e '▲ ▶ ▼ ◀ △ ▷ ▽ ◁'
echo -e '← → ↑ ↓ ↔ ↔ ↕ ↖ ↗ ↙ ↘ ↠ ↣ ↦ ↧ ↨ ↩ ↪ ↫ ↬ ↭ ↮ ↯ ↰ ↱ ↲ ↳ ↴ ↵ ↶ ↷ ↸ ↹ ↺ ↻ ↼ ↽ ↾ ↿ ↼ ↽ ↾ ↿'
echo -e '⇄ ↔ ⇀ ⇂ ⇄ ⇆ ⇌ ⇎ ⇐ ⇑ ⇓ ⇕ ⇖ ⇗ ⇘ ⇙ ⇚ ⇛ ⇜ ⇝ ⇞ ⇟'

echo
echo "Blocks:"
echo -e '▄ ▀ ▁ ▂ ▃ ▄ ▅ ▆ ▇ █ ▀ ▔ ▏ ▎ ▍ ▌ ▋ ▊ ▉ ▐ ▕ ▖ ▗ ▘ ▙ ▚ ▛ ▜ ▝ ▞ ▟ ░ ▒ ▓ 🮘 🮙 🮐  '
echo -e '▄ ▀ ▁ ▂ ▃ ▄ ▅ ▆ ▇ █ ▀ ▔ ▏ ▎ ▍ ▌ ▋ ▊ ▉ ▐ ▕ ▖ ▗ ▘ ▙ ▚ ▛ ▜ ▝ ▞ ▟ ░ ▒ ▓ 🮘 🮙 🮐  '
echo -e '▄ ▀ ▁ ▂ ▃ ▄ ▅ ▆ ▇ █ ▀ ▔ ▏ ▎ ▍ ▌ ▋ ▊ ▉ ▐ ▕ ▖ ▗ ▘ ▙ ▚ ▛ ▜ ▝ ▞ ▟ ░ ▒ ▓ 🮘 🮙 🮐  '
echo
echo -e '─────  ━━━━━ ┄┄┄┄┄ ┅┅┅┅┅ ┈┈┈┈┈ ┉┉┉┉┉ ╌╌╌╌╌ ╍╍╍╍╍ │ ┃ ┆ ┇ ┊ ┋ ╎ ╏ ║ ╵ ╷ ╹ ╻  '
echo -e '─────  ━━━━━ ┄┄┄┄┄ ┅┅┅┅┅ ┈┈┈┈┈ ┉┉┉┉┉ ╌╌╌╌╌ ╍╍╍╍╍ │ ┃ ┆ ┇ ┊ ┋ ╎ ╏ ║ ╵ ╷ ╹ ╻  '
echo -e '─────  ━━━━━ ┄┄┄┄┄ ┅┅┅┅┅ ┈┈┈┈┈ ┉┉┉┉┉ ╌╌╌╌╌ ╍╍╍╍╍ │ ┃ ┆ ┇ ┊ ┋ ╎ ╏ ║ ╵ ╷ ╹ ╻  '
echo
echo -e '╭──────────────╮ ┌─┬─┬─┬─┐ ╔═╦═╦═╦═╗ ┏━┳━┳━┳━┓ '
echo -e '│ border chars │ │ ├─┼─┤ │ ║ ╠═╬═╣ ║ ┃ ┣━╋━┫ ┃ '
echo -e '╰──────────────╯ └─┴─┴─┴─┘ ╚═╩═╩═╩═╝ ┗━┻━┻━┻━┛ '

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


## Color test

# Tom Hale, 2016. MIT Licence.
# Print out 256 colours, with each number printed in its corresponding colour
# See http://askubuntu.com/questions/821157/print-a-256-color-test-pattern-in-the-terminal/821163#821163

set -eu # Fail on errors or undeclared variables

printable_colours=256

# Return a colour that contrasts with the given colour
# Bash only does integer division, so keep it integral
function contrast_colour {
    local r g b luminance
    colour="$1"

    if (( colour < 16 )); then # Initial 16 ANSI colours
        (( colour == 0 )) && printf "15" || printf "0"
        return
    fi

    # Greyscale # rgb_R = rgb_G = rgb_B = (number - 232) * 10 + 8
    if (( colour > 231 )); then # Greyscale ramp
        (( colour < 244 )) && printf "15" || printf "0"
        return
    fi

    # All other colours:
    # 6x6x6 colour cube = 16 + 36*R + 6*G + B  # Where RGB are [0..5]
    # See http://stackoverflow.com/a/27165165/5353461

    # r=$(( (colour-16) / 36 ))
    g=$(( ((colour-16) % 36) / 6 ))
    # b=$(( (colour-16) % 6 ))

    # If luminance is bright, print number in black, white otherwise.
    # Green contributes 587/1000 to human perceived luminance - ITU R-REC-BT.601
    (( g > 2)) && printf "0" || printf "15"
    return

    # Uncomment the below for more precise luminance calculations

    # # Calculate percieved brightness
    # # See https://www.w3.org/TR/AERT#color-contrast
    # # and http://www.itu.int/rec/R-REC-BT.601
    # # Luminance is in range 0..5000 as each value is 0..5
    # luminance=$(( (r * 299) + (g * 587) + (b * 114) ))
    # (( $luminance > 2500 )) && printf "0" || printf "15"
}

# Print a coloured block with the number of that colour
function print_colour {
    local colour="$1" contrast
    contrast=$(contrast_colour "$1")
    printf "\e[48;5;%sm" "$colour"                # Start block of colour
    printf "\e[38;5;%sm%3d" "$contrast" "$colour" # In contrast, print number
    printf "\e[0m "                               # Reset colour
}

# Starting at $1, print a run of $2 colours
function print_run {
    local i
    for (( i = "$1"; i < "$1" + "$2" && i < printable_colours; i++ )) do
        print_colour "$i"
    done
    printf "  "
}

# Print blocks of colours
function print_blocks {
    local start="$1" i
    local end="$2" # inclusive
    local block_cols="$3"
    local block_rows="$4"
    local blocks_per_line="$5"
    local block_length=$((block_cols * block_rows))

    # Print sets of blocks
    for (( i = start; i <= end; i += (blocks_per_line-1) * block_length )) do
        printf "\n" # Space before each set of blocks
        # For each block row
        for (( row = 0; row < block_rows; row++ )) do
            # Print block columns for all blocks on the line
            for (( block = 0; block < blocks_per_line; block++ )) do
                print_run $(( i + (block * block_length) )) "$block_cols"
            done
            (( i += block_cols )) # Prepare to print the next row
            printf "\n"
        done
    done
}

echo
echo "ANSI 4-bit colors:"
echo

print_run 0 16 # The first 16 colours are spread over the whole spectrum

echo
echo
echo "ANSI 8-bit colors:"

print_blocks 16 231 6 6 3 # 6x6x6 colour cube between 16 and 231 inclusive
print_blocks 232 255 12 2 1 # Not 50, but 24 Shades of Grey
