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





#Part C | Requirement 1 - Find Script

NAME
	find_script - Find Script

SYNOPSIS
	./find_script.sh

DESCRIPTION
	Find Script is a user friendly menu interface for the popular unix command "find"
	asking for user input to specific questions to help the user find what they're looking
	for and execute the appropriate action on the findings. Find Script also enables the
	user to enter their own 'scriplet' to execute on results.

OPTIONS
	No options available this is a menu based script

FILES
	find_script.sh
		The script which runs as is, requires user input via prompts

AUTHOR
	Elijah Glass (s3679959) s3679959@student.rmit.edu.au

Linux 									Last change: NOVEMBER 2018




#Part C | Requirement 2 - Basic Profiler

NAME
	 profiler - Basic Profiler

SYNOPSIS
	./profiler.sh

DESCRIPTION
	Basic Profiler is a user friendly way for live monitoring or a programs strain on your
	systems resources. The menu driven program simply asks for a program and what you'd like 
	to monitor either CPU or Memory and displays the result every second. Best used in 
	conjunction with script_call_menu.

OPTIONS
	No options available this is a menu based script

FILES
	profiler.sh
		The script which runs as is, requires user input via prompts
	profiler_monitor.sh
		A script called by profiler.sh which returns the usage every second.

AUTHOR
	Elijah Glass (s3679959) s3679959@student.rmit.edu.au

Linux 									Last change: NOVEMBER 2018




#Part C | Requirement 3 - Menu System

NAME
	 script-call-menu - Menu System

SYNOPSIS
	./script-call-menu.sh

DESCRIPTION
	A menu driven script which is specifically designed to call the other scripts in this 
	package.

OPTIONS
	No options available this is a menu based script

FILES
	script-call-menu.sh
		The script which runs as is, requires user input via prompts.

AUTHOR
	Elijah Glass (s3679959) s3679959@student.rmit.edu.au

Linux 									Last change: NOVEMBER 2018

