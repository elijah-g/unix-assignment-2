# Unix Administation Assignment 2
Implementation of the Assignment 2 part B requirements 1 and 2.

# Requirement 1 - sysinfo.sh
NAME
	sysinfo - System Information

SYNOPSIS
	sysinfo [-memory] [-disk] [-network] [-uptime] [-help]

DESCRIPTION
	sysinfo calls on commonly available unix commands and files
	to display information on the system to the user. Giving
	the user one stop for their needs on system information.
	Takes one argument at a time.

OPTIONS
	-memory     view used and available memory
	-disk       view a report of the disk of you system
	-network    a report on the networking interface
	-uptime     view the uptime of your system
	-help		view the usage and options of sysinfo

FILES
	sysinfo.sh
		The script which takes a single argument and displays as directed

AUTHOR
	Elijah Glass (s3679959) s3679959@student.rmit.edu.au

Linux 									Last change: NOVEMBER 2018


#Requirement 2 - opinfo.sh
NAME
	opinfo - Operation Information

SYNOPSIS
	opinfo [-c][-p][-r][-o][-m]

DESCRIPTION
	opinfo uses a combination of linux commands to find different 
	infromation	on the operation of the system including cpu cores,
	information on file descriptors and more!

OPTIONS
	-c     the number of cpu cores on the system
	-p     the current process' priority (nice number)
	-r     the total number of processes running under the current user
	-o     the number of open file descriptors owned by the current user
	-m     the maximum default number of file descritpors that can be opened by a process

FILES
	opinfo.sh
		The script which takes one or more arguments and displays info to user.

AUTHOR
	Elijah Glass (s3679959) s3679959@student.rmit.edu.au

Linux 									Last change: NOVEMBER 2018	


#	