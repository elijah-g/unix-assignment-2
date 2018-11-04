#!/bin/bash
#Elijah Glass - S3679959

#Define variables for executables
GREP="/bin/grep"
PGREP="/bin/pgrep"
PS="/bin/ps"
GETOPTS="/bin/getopts"
ECHO="bin/echo"
ID="/bin/id"
WC="/bin/wc"
LSOF="/bin/lsof"
CAT="/bin/cat"
AWK="/bin/awk"
EXPR="bin/expr"


#Function that can be reused to give guidance if an innapropriate argument is given
function help_required {
	echo "Usage: opinfo [-c][-p][-r][-o][-m]"
	echo
	echo "-c     the number of cpu cores on the system"
	echo "-p     the current process' priority (nice number)"
	echo "-r     the total number of processes running under the current user"
	echo "-o     the number of open file descriptors owned by the current user"
	echo "-m     the maximum default number of file descritpors that can be opened by a process"
	echo
	echo "For more help read READ.ME"
}

if [ -n "$1" ]; then

	while getopts cprom parm ; do
		case $parm in
			c)
				cores="$(grep -c ^processor /proc/cpuinfo)"
				echo "Number of CPU cores: $cores" 
				;;

			p)	
				#Find the pid of this script using pgrep		
				pid="$(pgrep -f "$0")"
				
				#Find it's priority number using ps
				priority="$(ps --no-headers -o ni "$pid")"

				#Display the output nicely on the screen
				echo "Current process nice priority number:$priority"
				;;

			r)
				#find the current users username using id
				user="$(id -u -n)"

				#Count using wc thee number of line of the output of ps for specific user
				#each process has a line hence number of lines = number of processes
				num_processes="$(ps --no-headers -U "$user" | wc -l)"

				#Display the output nicely on the screen
				echo "Number of process for user $user: $num_processes"
				;;

			o)
				#find current username
				user="$(id -u -n)"

				#Find number of file descriptors open by user.
				num_fd="$(lsof -a -d 0-999 -u "$user" | wc -l)"

				#Display the output nicely on the screen
				echo "Number of open file descriptors for $user: $num_fd"
				;;

			m)
				#find amount of occupied file descriptors
				occupied="$(cat /proc/sys/fs/file-nr | awk '{print $1;}')"

				#Then find number of total system file descriptors
				total="$(cat /proc/sys/fs/file-max)"

				#calculate available file descriptors. Subtract occupied from total
				available="$(expr "$total" - "$occupied")"

				#Display the output nice"ly on the screen
				echo "Number of available file descriptors: $available"
				;;

			*)
				echo "Inavalid option"
				help_required

		esac
	done

#If no agument specified 
else
	echo "No argument was specified"
	help_required
fi