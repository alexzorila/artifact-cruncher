#!/bin/bash

# Flag to check if a valid argument was provided
valid_arg=false

# Execute setup scripts based on provided arguments
for arg in "$@"; do
    case "$arg" in
        parse) echo -e "\nExecuting ./parse/setup.sh..."; cd parse && ./setup.sh; valid_arg=true ;;
		splunk) echo -e "\nExecuting ./splunk/setup.sh..."; cd splunk && setup.sh; valid_arg=true ;;
    esac
done

# Notify the user if no valid keyword was provided
if [ "$valid_arg" = false ]; then
    echo -e "\n\tNo valid parameter passed!"
	echo -e "\tUse 'parse' or 'splunk' to install one or both."
	echo -e "\n\tExamples:"
	echo -e "\t- Install both: ./setup.sh parse splunk"
	echo -e "\t- Install parser: ./setup.sh parse"
	echo -e "\t- Install splunk: ./setup.sh splunk\n"
    exit 1
fi
echo -e "\nDone!\n"
