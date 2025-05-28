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
version="v.1.2b"
destWord="current directory"
destPath=$(pwd)
file=""
quietMode=""
simulate=""
audioFormat="mp3"
videoFormat="mp4"


function continue()
{
	echo ""
	echo -e "${White}"
	read -s -p "		Press enter to continue..." temp
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
	echo -e "						- $version"
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

function showAudioFormatMenu()
{
	clear
	echo -e "${White}========== ${Red} AUDIO FORMAT${White} =========="
	echo ""
	echo -e "	[${Red}1${White}] aac\n	[${Red}2${White}] alac\n	[${Red}3${White}] flac\n	[${Red}4${White}] m4a\n	[${Red}5${White}] mp3 (Default)\n	[${Red}6${White}] opus\n	[${Red}7${White}] vorbis\n	[${Red}8${White}] wav\n\n	[${Red}9${White}] Back"
	echo -e "${White}==================================="
	echo ""
	read -p "Select Option: " choice
	case $choice in

	1)
		audioFormat="aac"
		clear
		echo -e "${White}========== ${Red} AUDIO FORMAT${White} =========="
		echo ""
		echo -e "	${White}Audio format set to ${Red}aac${White}."
		continue
		showFormatMenu
		;;
	2)
		audioFormat="alac"
		clear
		echo -e "${White}========== ${Red} AUDIO FORMAT${White} =========="
		echo ""
		echo -e "	${White}Audio format set to ${Red}alac${White}."
		continue
		showFormatMenu
		;;
	3)
		audioFormat="flac"
		clear
		echo -e "${White}========== ${Red} AUDIO FORMAT${White} =========="
		echo ""
		echo -e "	${White}Audio format set to ${Red}flac${White}."
		continue
		showFormatMenu
		;;
	4)
		audioFormat="m4a"
		clear
		echo -e "${White}========== ${Red} AUDIO FORMAT${White} =========="
		echo ""
		echo -e "	${White}Audio format set to ${Red}m4a${White}."
		continue
		showFormatMenu
		;;
	5)
		audioFormat="mp3"
		clear
		echo -e "${White}========== ${Red} AUDIO FORMAT${White} =========="
		echo ""
		echo -e "	${White}Audio format set to ${Red}mp3${White}."
		continue
		showFormatMenu
		;;
	6)	
		audioFormat="opus"
		clear
		echo -e "${White}========== ${Red} AUDIO FORMAT${White} =========="
		echo ""
		echo -e "	${White}Audio format set to ${Red}opus${White}."
		continue
		showFormatMenu
		;;
	7)
		audioFormat="vorbis"
		clear
		echo -e "${White}========== ${Red} AUDIO FORMAT${White} =========="
		echo ""
		echo -e "	${White}Audio format set to ${Red}vorbis${White}."
		continue
		showFormatMenu
		;;
	8)
		audioFormat="wav"
		clear
		echo -e "${White}========== ${Red} AUDIO FORMAT${White} =========="
		echo ""
		echo -e "	${White}Audio format set to ${Red}wav${White}."
		continue
		showFormatMenu
		;;
	9)
		showFormatMenu
		;;
	*)
		showAudioFormatMenu
		;;
	esac
}

# Function that displays the video format menu. This is where users can set their preferred video format
function showVideoFormatMenu()
{
	# Supported video formats: avi, flv, gif, mkv, mov, mp4, webm
	clear
	echo -e "${White}========== ${Red} VIDEO FORMAT${White} =========="
	echo ""
	echo -e "	[${Red}1${White}] avi\n	[${Red}2${White}] flv\n	[${Red}3${White}] gif\n	[${Red}4${White}] mkv\n	[${Red}5${White}] mov\n	[${Red}6${White}] mp4 (Default)\n	[${Red}7${White}] webm\n\n	[${Red}8${White}] Back"
	echo -e "${White}==================================="
	echo ""
	read -p "Select Option: " choice
	case $choice in

	1)
		videoFormat="avi"
		clear
		echo -e "${White}========== ${Red} VIDEO FORMAT${White} =========="
		echo ""
		echo -e "	${White}Video format set to ${Red}avi${White}."
		continue
		showFormatMenu
		;;
	2)
		videoFormat="flv"
		clear
		echo -e "${White}========== ${Red} VIDEO FORMAT${White} =========="
		echo ""
		echo -e "	${White}Video format set to ${Red}flv${White}."
		continue
		showFormatMenu
		;;
	3)
		videoFormat="gif"
		clear
		echo -e "${White}========== ${Red} VIDEO FORMAT${White} =========="
		echo ""
		echo -e "	${White}Video format set to ${Red}gif${White}."
		continue
		showFormatMenu
		;;
	4)
		videoFormat="mkv"
		clear
		echo -e "${White}========== ${Red} VIDEO FORMAT${White} =========="
		echo ""
		echo -e "	${White}Video format set to ${Red}mkv${White}."
		continue
		showFormatMenu
		;;
	5)
		videoFormat="mov"
		clear
		echo -e "${White}========== ${Red} VIDEO FORMAT${White} =========="
		echo ""
		echo -e "	${White}Video format set to ${Red}mov${White}."
		continue
		showFormatMenu
		;;
	6)
		videoFormat="mp4"
		clear
		echo -e "${White}========== ${Red} VIDEO FORMAT${White} =========="
		echo ""
		echo -e "	${White}Video format set to ${Red}mp4${White}."
		continue
		showFormatMenu
		;;
	7)
		videoFormat="webm"
		clear
		echo -e "${White}========== ${Red} VIDEO FORMAT${White} =========="
		echo ""
		echo -e "	${White}Video format set to ${Red}webm${White}."
		continue
		showFormatMenu
		;;
	8)
		showFormatMenu
		;;
	*)
		showVideoFormatMenu
		;;
	esac
}

function showFormatMenu()
{
	clear
	echo -e "${White}========== ${Red} FORMAT OPTIONS${White} =========="
	echo ""
	echo -e "	[${Red}1${White}] Set Audio Format\n	[${Red}2${White}] Set Video Format\n\n	[${Red}3${White}] Back"
	echo -e "${White}====================================="
	echo ""
	read -p "Select Option: " choice
	case $choice in	
		
	1)
		showAudioFormatMenu
		;;
	2)
		showVideoFormatMenu
		;;
	3)
		showMainMenu
		;;
	*)
		showFormatMenu
		;;
	esac
}

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
			yt-dlp -x --audio-format $audioFormat -P $destPath -o '%(title)s.%(ext)s' --batch-file $file --no-warnings $simulate
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
			case "$videoFormat" in
			mp4|mkv)
				yt-dlp -f bestvideo*+bestaudio/best --remux-video "$videoFormat" -P "$destPath" -o '%(title)s.%(ext)s' $link $quietMode --no-warnings $simulate
				;;
			*)
				video_title=$(yt-dlp -f bestvideo*+bestaudio/best --remux-video mp4 -P "$destPath" -o '%(title)s.%(ext)s' $simulate --print after_move:filepath --no-warnings "$link" | tail -n 1)
				output_file="${video_title%.*}.$videoFormat"
				if ffmpeg -loglevel fatal -i "$video_title" "$output_file"; then
					rm "$video_title"
					echo -e "	Video successfully extracted to $output_file"
				else
					echo -e "	ffmpeg failed! The original file has been kept for troubleshooting."
				fi
			;;
			esac
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
	echo -e "	[${Red}1${White}] Audio Extract\n	[${Red}2${White}] Video Extract\n	[${Red}3${White}] Extract From File\n\n	[${Red}4${White}] Destination Path Settings\n	[${Red}5${White}] Format Settings\n\n	[${Red}6${White}] Internal Options\n\n	[${Red}7${White}] Credits\n	[${Red}99${White}] Exit"
	echo -e "${White}======================================="
	echo ""
	read -p "Select option: " choice
	case $choice in

	1)
		clear
		echo -e "${White}=============== ${Red}EXTRACT ${White}==============="
		read -p "Enter link: " link
		yt-dlp -x --audio-format $audioFormat -P $destPath -o '%(title)s.%(ext)s' $link $quietMode --no-warnings $simulate
		continue
		showMainMenu
		;;
	2)
		clear
        echo -e "${White}=============== ${Red}EXTRACT ${White}==============="
        read -p "Enter link: " link
        #TODO: In later versions consider adding fancier logic to this section.
		# mp4 and mk4 can always be remuxed to
		# mov and webm can sometimes fail and need to check wether or not remuxing was successful
		# avi, flv and gif always need to be converted using ffmpeg
		case "$videoFormat" in
			mp4|mkv)
				yt-dlp -f bestvideo*+bestaudio/best --remux-video "$videoFormat" -P "$destPath" -o '%(title)s.%(ext)s' $link $quietMode --no-warnings $simulate
				;;
			*)
				video_title=$(yt-dlp -f bestvideo*+bestaudio/best --remux-video mp4 -P "$destPath" -o '%(title)s.%(ext)s' $simulate --print after_move:filepath --no-warnings "$link" | tail -n 1)
				output_file="${video_title%.*}.$videoFormat"
				if ffmpeg -loglevel fatal -i "$video_title" "$output_file"; then
					rm "$video_title"
					echo -e "	Video successfully extracted to $output_file"
				else
					echo -e "	ffmpeg failed! The original file has been kept for troubleshooting."
				fi
			;;
		esac
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
		showFormatMenu
		;;
	6)
		showInternalMenu
		;;
	7)
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
