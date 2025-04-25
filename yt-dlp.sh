#!/bin/bash

# Definition of colors
Black='\033[0;30m'	  # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'	  # Green
Orange='\033[0;33m'	  # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'	  # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'	  # White

# Global variable definition
destWord="current directory"
destPath=$(pwd)
file=""
quietMode=""
simulate=""


function continue()
{
	echo ""
	echo -e "${White}"
	read -p "		Press enter to continue..." temp
}

function showCredits()
{
	clear
	echo -e "${Red}"
	echo -e " 	███▄ ▄███▓ ▄▄▄      ▓█████▄ ▓█████     ▄▄▄▄ ▓██   ██▓"
	echo -e "	▓██▒▀█▀ ██▒▒████▄    ▒██▀ ██▌▓█   ▀    ▓█████▄▒██  ██▒"
	echo -e "	▓██    ▓██░▒██  ▀█▄  ░██   █▌▒███      ▒██▒ ▄██▒██ ██░"
	echo -e "	▒██    ▒██ ░██▄▄▄▄██ ░▓█▄   ▌▒▓█  ▄    ▒██░█▀  ░ ▐██▓░"
	echo -e "	▒██▒   ░██▒ ▓█   ▓██▒░▒████▓ ░▒████▒   ░▓█  ▀█▓░ ██▒▓░"
	echo -e "	░ ▒░   ░  ░ ▒▒   ▓▒█░ ▒▒▓  ▒ ░░ ▒░ ░   ░▒▓███▀▒ ██▒▒▒ "
	echo -e "	░  ░      ░  ▒   ▒▒ ░ ░ ▒  ▒  ░ ░  ░   ▒░▒   ░▓██ ░▒░ "
	echo -e "	░      ░     ░   ▒    ░ ░  ░    ░       ░    ░▒ ▒ ░░  "
	echo -e "	       ░         ░  ░   ░       ░  ░    ░     ░ ░     "
	echo -e "	                      ░                      ░░ ░     "
	echo -e "	 ▄▄▄▄    ██▓ ██▓    ▄▄▄      "
	echo -e "	▓█████▄ ▓██▒▓██▒   ▒████▄    "
	echo -e "	▒██▒ ▄██▒██▒▒██░   ▒██  ▀█▄  "
	echo -e "	▒██░█▀  ░██░▒██░   ░██▄▄▄▄██ "
	echo -e "	░▓█  ▀█▓░██░░██████▒▓█   ▓██▒"
	echo -e "	░▒▓███▀▒░▓  ░ ▒░▓  ░▒▒   ▓▒█░"
	echo -e "	▒░▒   ░  ▒ ░░ ░ ▒  ░ ▒   ▒▒ ░"
	echo -e "	 ░    ░  ▒ ░  ░ ░    ░   ▒   "
	echo -e "	 ░       ░      ░  ░     ░  ░"
	echo -e "	      ░                      "
	echo -e "						- v.1.2"
	echo ""
	continue
}

# Function that checks if all links in a given file are valid
function validate_links()
{
    local file="$1"
    local is_valid=true

    while IFS= read -r line; do
        if [[ ! "$line" =~ ^(https:\/\/)?(www\.)?(youtube\.com|youtu\.be)\/ ]]; then
            echo "Invalid YouTube link found: $line"
            is_valid=false
            break
        fi
    done < "$file"

    if [ "$is_valid" = true ]; then
        #echo "All links are valid YouTube links."
        return 0  # Success
    else
        #echo "One or more invalid links found."
        return 1  # Failure
    fi
}

# Usage:
#if validate_links "links.txt"; then

# Function that displays the file options menu. This is where users must set their input file
function showFileOptionsMenu()
{
	clear
	echo -e "${White}=========== ${Red}FILE OPTIONS${White} ==========="
	echo ""
	echo -e "	[${Red}1${White}] Input File Path/Name\n	[${Red}2${White}] Create File\n\n	[${Red}3${White}] Edit File\n\n	[${Red}4${White}] Back"
	echo -e "${White}===================================="
	echo ""
	read -p "Select Option: " choice
	case $choice in

	1)
		clear
		echo -e "${White}=========== ${Red}INPUT FILE${White} ==========="
		echo ""
		read -p "Enter file path/name: " tempfile
		clear
		echo ""
		echo ""
		if [ -f "$tempfile" ]; then
			file=$tempfile
			echo -e "	File path successfully set to $file"
		else
			echo -e "	File path invalid or doesn't point to a file."
			echo ""
			echo -e "	File path has not been updated."
		fi
		continue
		showFileOptionsMenu
		;;
	2)
		clear
		echo -e "${White}=========== ${Red}CREATE FILE${White} ==========="
		echo ""
		read -p "Enter file name: " filename
		if [[ "$filename" == *.txt ]]; then
			final_file="$filename"
		else
			final_file="${filename}.txt"
		fi
		touch "$final_file"
		clear
		echo ""
		echo -e "	Successfully created $final_file"
		continue
		showFileOptionsMenu
		;;
	3)
		clear
		echo -e "=========== ${Red}EDIT FILE${White} ==========="
		echo ""
		read -p "Enter file/path to edit: " path
		if [ -f "$path" ]; then
			clear
			nano $path
		else
			clear
			echo ""
			echo "	Provided path is invalid or does not point to a file."
			continue
		fi
		showFileOptionsMenu
		;;
	4)
		showFileMenu
		;;
	*)
		showFileOptionsMenu
		esac
}

# Menu that allows users to extract audio/video from all links in a given input file. This is recommended for mass downloading
function showFileMenu()
{
	clear
	echo -e "${White}=========== ${Red}EXTRACT FROM FILE ${White}==========="
	echo ""
	echo -e "	[${Red}1${White}] Audio Extract From File\n	${White}[${Red}2${White}] Video Extract From File\n\n	${White}[${Red}3${White}] File Options\n\n	${White}[${Red}4${White}] Back"
	echo -e "${White}========================================="
	echo ""
	read -p "Select Option: " choice
	case $choice in

	1)
		clear
		echo -e "${White}=============== ${Red}EXTRACT${White} ==============="
		echo ""
		if [ -z "$file" ]; then
			echo -e "	No file has been selected in the file options menu."
			echo -e "	Please select one and try to extract again."
			continue
			showFileMenu
		fi
		if validate_links $file; then
			yt-dlp -x --audio-format mp3 -P $destPath -o '%(title)s.%(ext)s' --batch-file $file --no-warnings
			continue
		else
			echo -e "	One or more links are invalid."
			continue
		fi
		showFileMenu
		;;
	2)
		clear
        	echo -e "${White}=============== ${Red}EXTRACT${White} ==============="
        	echo ""
		if validate_links $file; then
			yt-dlp -f bestvideo*+bestaudio/best --remux-video mp4 -P $destPath -o '$(title)s.%(ext)s' --batch-file $file --no-warnings
			continue
		else
			echo -e "	One or more links are invalid."
			continue
		fi
		showFileMenu
		;;
	3)
		showFileOptionsMenu
		;;
	4)
		showMainMenu
		;;
	*)
		showFileMenu
		;;
	esac
}

# Sub-menu for changing the output destination path
function showPathMenu()
{
	clear
	echo -e "${White}=========== ${Red}DESTINATION PATH ${White}==========="
	echo ""
	echo -e "	[${Red}1${White}] Current Directory\n	[${Red}2${White}] User-Provided Directory\n\n	[${Red}3${White}] Back"
	echo -e "${White}========================================"
	echo ""
	read -p "Select Option: " choice
	case $choice in

	1)
		clear
		destPath=$(pwd)
		destWord="current directory"
		echo ""
		echo ""
		echo "	Output destination set to current working directory"
		continue
		showPathMenu
		;;
	2)
		clear
		echo ""
		read -p "Input destination path: " dest
		clear
		if [ -e "$dest" ]; then
			echo ""
			echo ""
			echo "	The path '$dest' exists and is valid."
			destPath=$dest
			destWord=$dest
			echo "	Output destination path successfully set."
			continue
			showPathMenu
		else
			echo ""
			echo ""
			echo "	The path provided by the user is invalid."
			echo ""
			echo "	Output destination path has not been updated."
			continue
			showPathMenu
		fi
		;;
	3)
		showMainMenu
		;;
	*)
		showPathMenu
		;;
	esac
}

# Internal Options menu, allows user to tweak with various settings yt-dlp provides
function showInternalMenu()
{
	clear
	echo -e "${White}=========== ${Red} INTERNAL OPTIONS ${White}==========="
	echo ""
	echo -e "	[${Red}1${White}] Update yt-dlp\n	[${Red}2${White}] Toggle Quiet Mode\n	[${Red}3${White}] Toggle Simulate\n\n	[${Red}4${White}] Back"
	echo -e "=========================================\n"
	read -p "Select option: " choice
	clear
	case $choice in

	1)
		echo -e "${White}========== ${Red}UPDATE${White} =========="
		echo ""
		echo -e "Would you like to update yt-dlp?\n"
		read -p "[Y/n] " update
		case $update in

			y)
				clear
				yt-dlp --update
				echo "Finished updating yt-dlp."
				continue
				;;
			Y)
                                clear
                                yt-dlp --update
                                echo "Finished updating yt-dlp."
                                continue
                                ;;
			yes)
                                clear
                                yt-dlp --update
                                echo "Finished updating yt-dlp."
                                continue
                                ;;
		esac
		showInternalMenu
		;;
	2)
		echo -e "======== ${Red}QUIET MODE${White} ========"
		echo ""
		if [[ -z "$quietMode" ]]; then
			quietMode="--quiet"
			echo -e "Quiet mode has been turned [${Green}ON${White}]."
			continue
		else
			quietMode=""
			echo -e "Quiet mode has been turned [${Red}OFF${White}]."
			continue
		fi
		showInternalMenu
		;;
	3)
		echo -e "======== ${Red}SIMULATE${White} ========"
		echo ""
		if [[ -z "$simulate" ]]; then
			simulate="--simulate"
			echo -e "Simulate has been turned  [${Green}ON${White}]."
			continue
		else
			simulate=""
			echo -e "Simulate has been turned [${Red}OFF${White}]."
			continue
		fi
		showInternalMenu
		;;
	4)
		showMainMenu
		;;
	*)
		showInternalMenu
		;;
	esac
}

# Main menu, top layer of script
function showMainMenu()
{
	clear
	echo -e "${White}============== ${Red}MAIN MENU ${White}=============="
	echo ""
	echo -e "	[${Red}1${White}] Audio Extract\n	[${Red}2${White}] Video Extract\n	[${Red}3${White}] Extract From File\n\n	[${Red}4${White}] Destination Path Settings\n\n	[${Red}5${White}] Internal Options\n\n	[${Red}6${White}] Credits\n	[${Red}99${White}] Exit"
	echo -e "${White}======================================="
	echo ""
	read -p "Select option: " choice
	case $choice in

	1)
		clear
		echo -e "${White}=============== ${Red}EXTRACT ${White}==============="
		read -p "Enter link: " link
		yt-dlp -x --audio-format mp3 -P $destPath -o '%(title)s.%(ext)s' $link $quietMode --no-warnings
		continue
		showMainMenu
		;;
	2)
		clear
		echo -e "${White}=============== ${Red}EXTRACT ${White}==============="
		read -p "Enter link: " link
		yt-dlp -f bestvideo*+bestaudio/best --remux-video mp4 -P $destPath -o '%(title)s.%(ext)s' --no-warnings $link
		continue
		showMainMenu
		;;
	3)
		showFileMenu
		;;
	4)
		showPathMenu
		;;
	5)
		showInternalMenu
		;;
	6)
		showCredits
		showMainMenu
		;;
	99)
		clear
		exit
		;;
	*)
		showMainMenu
		;;
	esac
}

#showCredits
showMainMenu
