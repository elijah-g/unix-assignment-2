#!/bin/bash
#Elijah Glass S3679959

#Define variables for executables
GREP="/bin/grep"
ECHO="/bin/echo"
FIND="/bin/find"

#Function which is a menu for user to select what thing to search for
#PATH, TYPE, GROUP, FSTYPE
function select_thing {
	PS3="Select the thing to search for: "
	options=("path" "type" "group" "fstype")
	select option in "${options[@]}"
	do
	    case $option in
	        "path")
				thing="path"
				break
	            ;;
	        "type")
	            thing="type"
	            break
	            ;;
	        "group")
	            thing="group"
	            break
	            ;;
	        "fstype")
				thing="fstype"
				break
	            ;;
	        *) 
				echo "invalid option $REPLY... Try Again."
				select_thing
				break
				;;
	    esac
	done
}


#Function which asks user for the action they'd like to take
#If they select custom it prompts them to enter their scriptlet
function take_action {
	custom=2
	PS3="What action would you like to take on the search results: "
	options=("delete" "print" "print0" "custom")
	select option in "${options[@]}"
	do
	    case $option in
	        "delete")
				action="delete"
				break
	            ;;
	        "print")
	            action="print"	
	            break            
	            ;;
	        "print0")
	            action="print0"	
	            break            
	            ;;
	        "custom")
				custom=1
				read -p "Enter your custom scriplet to apply: " scriplet
				break
	            ;;
	        *) 
				echo "invalid option $REPLY... Try Again."
				take_action
				;;
	    esac
	done
}


#Command which constructs the find command based on entered preferences
function find_command {
	
	#check if a depth was specified
	#And create part 1 of the command accordingly	
	if ! [ -z "$1" ] ; then
		if [ "$2" -eq 1 ] ; then
			cmd_part1="find -L "$directory" -maxdepth "$depth" -"$thing" "$value""
			
		else
			cmd_part1="find "$directory" -maxdepth "$depth" -"$thing" "$value""
			
		fi
	else
		if ! [ "$2" -eq 1 ] ; then
			cmd_part1="find -L "$directory" -"$thing" "$value""
			
		else
			cmd_part1="find "$directory" -"$thing" "$value""
			
		fi
	fi
	
	#Check the action the user specificied
	if [ "$custom" -eq 1 ] ; then
		cmd_part2="-exec $scriplet"
	else
		cmd_part2="-$action"
	fi

	eval "$cmd_part1 $cmd_part2"
	
	#check for a returned 1 and prompt user to try again.
	if [ "$?" -eq 1 ] ; then
		echo "One or more of the options you specified were not correct check man find and try again."
		echo "exiting script...."
		echo
		exit
	fi
}


#Function which asks user if they'd like to follow sym links.
#This function then calls the find command from previous functoin
#And passes into the function whether to check symbolic links or not.
function symlink_check {
	read -p "Would you like to follow symbolic links? (Y/N) " sym_links
	echo
	#Make the answer uppercase.
	sym_links=${sym_links^^}

	case "$sym_links" in
		Y) 
			find_command "$depth" 1
			;;
		N) 
			find_command "$depth" 2
			;;

		*) echo "Try Again, please specify 'Y' or 'N'!!!"
			symlink_check
			;;
	esac

}




#Ask user for input where they would like to start their search
read -p "Where would you like to start? " directory

#call function which prompts user to select what thing they'd like to search for
select_thing


#Read for the value to apply to thing
read -p "Value applied to thing to search for: " value


#Check how deep they'd like to go in their search
read -p "Please specify max depth for search (enter for none): " depth

#Prompt for the action they'd like to apply
take_action

#Prompt whether to follow symbolic links
#this function also runs the find command and executes the action.
symlink_check

#THE END!