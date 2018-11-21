#!/bin/bash
#Elijah Glass S3679959


#Define variables for executables
PS="/bin/ps"
PIDOF="/bin/pidof"
ECHO="/bin/echo"
SED="/bin/sed"
SLEEP="/bin/sleep"

#Create some space
echo 


#Make a case to see what we should be doing
case "$1" in

	-m) echo "**Memory Report**"
		loop=0
		#Start a loop to continiously display result
		while [ $loop -eq 0 ]; do
			usage=0
			#Loops to read and add each line of the command
			while read line ; do
				#Remove leading Zero
				line=$(echo $line | sed 's/^0*//')
				#Remove decimal point
				line="${line//./}"
				#Add to what we've already calculated
				usage=$(($usage + $line))

			#Command which uses the process ids of the passed command
			done < <(ps --no-headers -o pmem -p $(pidof $2))
			
			#Display the sum of usage and add the dot back in
			echo "${usage::(-1)}.${usage: (-1)} %"
			
			#Have a break
			sleep 1
		done
		;;

	-c) echo "**CPU**"
		loop=0
		while [ $loop -eq 0 ]; do
			usage=0
			while read line ; do
				#Remove leading Zero
				line=$(echo $line | sed 's/^0*//')
				#Remove decimal point
				line="${line//./}"
				#Add to what we've already calculated
				usage=$(($usage + $line))
			
			#Command which uses the process ids of the passed command
			done < <(ps --no-headers -o pcpu -p $(pidof $2))
			
			#Display the sum of usage and add the dot back in
			echo "${usage::(-1)}.${usage: (-1)} %"
			
			#have a break
			sleep 1
		done
		;;
esac
