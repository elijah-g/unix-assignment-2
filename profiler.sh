#!/bin/bash
#Elijah Glass S3679959


#Define variables for executables
PS="/bin/ps"
AWK="/bin/awk"
ECHO="/bin/echo"
TR="/bin/tr"
SORT="/bin/sort"
KILL="/bin/kill"


#Trap CTRL + C
trap '' 2

read -p "Which program would you like to profile? " program

#Prepare the program for use in regular expression
re_prep1= echo "$program" | cut -c 1
re_prep1="$(echo -e "${re_prep1}" | tr -d '[:space:]')"
re_prep2="${program:1}"
re_prep2="$(echo -e "${re_prep2}" | tr -d '[:space:]')"


#Set counter for while loop
count=0

#Read line of input from command at end
while read -r line
do
	#On first iternation create array
	if [ $count = 0 ] ; then
		if [[ "${line##*/}" =~ $program ]] ; then
			program_array+=("${line##*/}")
		fi

	#Other iterations check if already in array and add if not.
	else 

		#iterate over existing array	
		for i in "${program_array[@]}"
		do
			#Check if it's not the same
			if [ "${line##*/}" != "${program_array[$i]}" ] ; then
				#Add the line to the array
				if [[ "${line##*/}" =~ $program ]] ; then
					program_array+=("${line##*/}")
				fi
			
			#Otherwise keep on trucking
			else
				:
			fi
		done
	fi
	#increment counter
	count=$((count + 1))

#Command which cleverly selects processes containing the specified program.
done < <(ps aux | awk '/'"$re_prep1"''"$re_prep2"'/ {print $11}')


#sort the array. 
sorted_unique_ids=($(echo "${program_array[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))


#Remove duplicates.
final=($(echo "${sorted_unique_ids[@]}" | awk '/'"$re_prep1"''"$re_prep2"'/ {print $0}'))

#Create some space.
echo


#Check number of results
arraylength=${#final[@]}


#If not results return the error and exit program
if [ $arraylength -eq 0 ]; then
	echo "Your selected program does not exist or is not running TRY AGAIN"
	exit 1
fi

#If multiple results ask which they'd like
if [ $arraylength -gt 1 ]; then
	echo "More than one match. Pick your program...."

	for j in "${!final[@]}";
	do
		echo "$j.) ${final[$j]}"
	done

	#make selection higher than array length so the while loop can get a valid answer
	selection=$(( $arraylength + 1 ))
	
	while [ $selection -ge $arraylength  ] || [ $selection -lt 0 ]; do
		read -p "Enter the number you would like: " selection
	done

#If only 1 result then set the selection
else
	selection="${final[0]}"

fi


#Check if valid option....
echo "okay profiling ${final[$selection]}......"
echo 

#function to allow for selection of what to monitor
function select_monitor {
	PS3="Select the thing to monitor: "
	options=("Memory" "CPU")
	select option in "${options[@]}"
	do
	    case $option in
	        "Memory")
				#Call script which performs the function and run in background
				./profiler_monitor.sh -m "${final[$selection]}" &
				stop=0
				#Monitor for when enter is pressed to kill the background script and exit this one
				while [ $stop -eq 0 ]; do
					read stop
					if [[ $stop = "" ]]; then
						kill -9 $!
						exit
					fi

				done
				# pid=$!
	   #          kill $pid
	            ;;
	        "CPU")
	            #Call script which performs the function and runs in background
	            ./profiler_monitor.sh -c "${final[$selection]}" &
	            
	            stop=0
	            #Monitor for when enter is pressed to kill the background script and exit this one
				while [ $stop -eq 0 ]; do
					read stop
					if [[ $stop = "" ]]; then
						kill -9 $!
						exit
					fi
				done
	            ;;
	        *) 
				echo "invalid option $REPLY... Try Again."
				select_monitor
				break
				;;
	    esac
	done
}

select_monitor
