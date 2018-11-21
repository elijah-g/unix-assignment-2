#!/bin/bash
#Elijah Glass S3679959


#Define variables for executables
ECHO="/bin/echo"
CLEAR="bin/clear"


#Trap CTRL + C
trap '' 2

#Function for top menu
function top_menu {
	
	PS3='Please enter your choice: '
	options=("Basic System Info" "Find Things" "Profile a Process" "Quit")
	select option in "${options[@]}"
	do
	    case $option in
	        "Basic System Info")
				clear
	            basic_sys_info_menu
	            ;;
	        "Find Things")
				clear
	            ./find_script.sh
	            top_menu
	            ;;
	        "Profile a Process")
	            clear
	            ./profiler.sh
	            top_menu
	            ;;
	        "Quit")
				echo "Quiting...."
	            exit
	            ;;
	        *) echo "invalid option $REPLY";;
	    esac
	done
}

#Function for the menu when user selects basic system Info from top menu
function basic_sys_info_menu {
	
	PS3='Please enter your choice: '
	options=("Sys Info" "Op Info" "Return")
	select option in "${options[@]}"
	do
		case $option in
			"Sys Info")
				read -p "Specify arguments for script (leave blank for usage): " arguments
				clear
				./sysinfo.sh $arguments
				echo
				basic_sys_info_menu			
				;;
			"Op Info")
				read -p "Specify arguments for script (leave blank for usage): " arguments
				clear
				./opinfo.sh $arguments
				echo
				basic_sys_info_menu
				;;
			"Return")
				top_menu
				;;
		esac
	done	
}



#Get the program started by clearing the screen
clear

#Then display an obnoxious message for a few seconds
echo "Welcome to the marvelous script selector menu"
sleep 2

#Be humble
clear

#Run the menu!
top_menu

