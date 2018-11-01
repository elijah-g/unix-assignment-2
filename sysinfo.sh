#!/bin/bash
#Elijah Glass - S3679959


#Define variables for executables
FREE="/bin/free -h"
DF="/bin/df"
IFCONFIG="/bin/ifocnfig"
UPTIME="/bin/uptime -p"


#Function that can be reused to give guidance if an innapropriate argument is given
function help_required {
	echo "Usage: sysinfo [-memory][-disk][-network][-uptime][-help]"
	echo
	echo "-memory     view used and available memory"
	echo "-disk       view a report of the disk of you system"
	echo "-network    a report on the networking interface"
	echo "-uptime     view the uptime of your system"
	echo
	echo "For more help read READ.ME"
}


if [ "$#" -ne 1 ]; then
    echo "Script only takes one parameter... Ignoring all except the first"
fi

#Check to see if an argument was specified
if [ -n "$1" ]; then
	
	#Create a case for the first argument
	case "$1" in

	-memory) echo "**Memory Report**"
		eval $FREE
		;;

	-disk) echo "**Disk Space Report**"
		eval $DF
		;;

	-network) echo "**Network Report**"
		eval $IFCONIG
		;;

	-uptime) echo "**Uptime Report**"
		eval $UPTIME
		;;	

	-help) echo "**Help Requested**"
		help_required
		;;

	#Provide the user feedback if the argument was invalid
	*) echo "Argument invalid"
		help_required

	esac

#If no agument specified 
else
	echo "No argument was specified"
	help_required

fi

