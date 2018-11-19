#!/bin/bash
#Elijah Glass S3679959


#Ask user for input where they would like to start their search
read -p "Where would you like to start? " directory

#read -p "Select the thing to search for (path, type, group, fstype): " thing
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
				;;
	    esac
	done
}

function take_action {
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
				action=1
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

select_thing

read -p "Value applied to thing to search for: " value

read -p "Please specify max depth for search (enter for none): " depth

function symlink_check {
	read -p "Would you like to follow symbolic links? (Y/N) " sym_links

	#Make the answer uppercase.
	sym_links=${sym_links^^}

	case "$sym_links" in
		Y) 
			find_command "$depth" 1
			;;
		N) echo "NO"
			;;

		*) echo "Try Again, please specify 'Y' or 'N'!!!"
			symlink_check
			;;
	esac

}


function find_command {
	
	#check if a depth was specified
	#And create part 1 of the command accordingly	
	if ! [ -z "$1" ] ; then
		if [ "$2" -eq 1 ] ; then
			cmd_part1="find -L "$directory" -"$thing" "$value" -maxdepth "$depth""
			echo "$?"
		else
			cmd_part1="find "$directory" -"$thing" "$value" -maxdepth "$depth""
			echo "$?"
		fi
	else
		if ! [ "$2" -eq 1 ] ; then
			cmd_part1=find -L "$directory" -"$thing" "$value"
			echo "$?"
		else
			cmd_part1="find "$directory" -"$thing" "$value""
			echo "$?"
		fi
	fi
	
	#Check the action the user specificied
	if [ action -eq 1 ] ; then
		cmd_part2="-exec $scriplet"
	else
		cmd_part2="-$action"
	fi

	eval "$cmd_part1 $cmd_part2"

}
#find "$directory" -"$thing" "$value"
take_action
symlink_check


