#!/bin/bash
#Elijah Glass 


#Check to see if an argument was specified
if [ -n "$1" ]; then
	
	#Create a case for the first argument
	case "$1" in

	-memory) echo "**Memory Report**"
		free -h 
		;;

	-disk) echo "**Disk Space Report**"
		df
		;;

	-network) echo "**Network Report**"
		ifconfig
		;;

	-uptime) echo "**Uptime Report**"
		uptime -p
		;;	

	#Provide the user feedback if the argument was invalid
	*) echo "Invalid Option"

	esac

#If no agument specified 
else
	echo "You must specify a parameter"

fi

