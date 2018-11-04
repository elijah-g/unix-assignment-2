#!/bin/bash
#Elijah Glass - S3679959

while getopts cprom parm ; do
	case $parm in
		c)
			cores="$(grep -c ^processor /proc/cpuinfo)"
			echo "Number of CPU cores: $cores" 
			;;

		p)	
			#Find the pid of this script using pgrep		
			pid="$(pgrep -f $0)"
			
			#Find it's priority number using ps
			priority="$(ps --no-headers -o ni $pid)"

			#Display the output nicely on the screen
			echo "Current process nice priority number:$priority"
			;;

		r)
			#find the current users username using id
			user="$(id -u -n)"

			#Count using wc thee number of line of the output of ps for specific user
			#each process has a line hence number of lines = number of processes
			num_processes="$(ps --no-headers -U $user | wc -l)"

			#Display the output nicely on the screen
			echo "Number of process for user $user: $num_processes"
			;;

		o)
			
			user="$(id -u -n)"
			num_fd="$(lsof -a -d 0-999 -u $user | wc -l)"
			echo "Number of open file descriptors for $user: $num_fd"
			;;

		m)
			#find amount of occupied file descriptors
			occupied="$(cat /proc/sys/fs/file-nr | awk '{print $1;}')"

			#Then find number of total system file descriptors
			total="$(cat /proc/sys/fs/file-max)"

			#calculate available file descriptors. Subtract occupied from total
			available="$(expr $total - $occupied)"

			#Display the output nicely on the screen
			echo "Number of available file descriptors: $available"
			;;

		*)
			echo "inavalid option"

	esac
done

