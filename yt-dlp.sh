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

# Screen that appears when first running script
function splashScreen()
{
	clear
	echo -e "${Orange}		Welcome to the yt-dlp easy downloading tool! ${White}\n"
	echo -e "This script was made in order to streamline the usage of the yt-dlp tool."
	echo -e "All you need to do is select options desired for output, destination path, etc."
	echo -e "After that, return to main menu, select the one of the extraction options, and input the desired link(s)."
	echo -e "									${Red}~ made by bila${White}\n"
	read -p "			Press enter to continue..." temp
	clear
}

# Sub-menu for changing the output destination path
function showPathMenu()
{
	clear
	echo -e "${White}=========== ${Red}DESTINATION PATH ${White}==========="
	echo -e "	[${Red}1${White}] Current Directory\n	[${Red}2${White}] User-Provided Directory\n\n	[${Red}3${White}] Exit"
	echo -e "${White}========================================"
	echo ""
	read -p "Select Option: " choice
	case $choice in

	1)
	clear
	destPath=$(pwd)
	destWord="current directory"
	echo "	Output destination set to current working directory ("$destPath")"
	echo ""
	read -p "			Press enter to continue..." temp
	showPathMenu
	;;
	2)
	clear
	echo ""
	read -p "Input destination path: " dest
	clear
	if [ -e "$dest" ]; then
	echo "	The path '$dest' exists and is valid."
	destPath=$dest
	destWord=$dest
	echo "	Output destination path successfully set."
	echo ""
	read -p "			Press enter to continue..." temp
	showPathMenu
	else
	echo "The path provided by the user is invalid."
	echo "Output destination path has not been updated."
	echo ""
	read -p "			Press enter to continue..." temp
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

# Main menu, top layer of script
function showMainMenu()
{
	clear
	echo -e "${White}============== ${Red}MAIN MENU ${White}=============="
	echo -e "	[${Red}1${White}] Audio Extract\n	[${Red}2${White}] Video Extract\n\n	[${Red}3${White}] Destination Path Settings\n\n	[${Red}4${White}] Exit"
	echo -e "${White}======================================="
	echo ""
	read -p "Select option: " choice
	case $choice in

	1)
	clear
	echo -e "${White}=============== ${Red}EXTRACT ${White}==============="
	read -p "Enter link: " link
	yt-dlp -x --audio-format mp3 -P $destPath -o '%(title)s.%(ext)s' $link --no-warnings
	#echo "		File(s) successfully downloaded to "$destWord"."
	echo ""
	read -p "			Press enter to continue..." temp
	showMainMenu
	;;
	2)
	clear
	echo -e "${White}=============== ${Red}EXTRACT ${White}==============="
	read -p "Enter link: " link
	yt-dlp -f bestvideo*+bestaudio/best --remux-video mp4 -P $destPath -o '%(title)s.%(ext)s' --no-warnings $link
	#echo "		File(s) successfully downloaded to "$destWord"."
	echo ""
	read -p "			Press enter to continue..." temp
	showMainMenu
	;;
	3)
	showPathMenu
	;;
	4)
	clear
	exit
	;;
	*)
	showMainMenu
	;;
	esac
}

splashScreen
showMainMenu
