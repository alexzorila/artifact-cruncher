#!/bin/bash

# Elevate session
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

# Flag to check if a valid argument was provided
valid_arg=false

# Execute setup scripts based on provided arguments
for arg in "$@"; do
    case "$arg" in
    parse)     
        echo -e "\nExecuting ./parse/setup.sh..."
        cd parse; chmod +x ./setup.sh; ./setup.sh; cd ..; valid_arg=true 
        ;;
    splunk) 
        echo -e "\nExecuting ./splunk/setup.sh..."
        cd splunk; chmod +x ./setup.sh; ./setup.sh; cd ..; valid_arg=true 
        ;;
    esac
done

# Help page. Notify user if no valid argument provided
if [ "$valid_arg" = false ]; then
    echo -e "\nError   : No valid script arguments passed! Specify one or both to install corresponding module."
    echo -e "Options : 'parse', 'splunk'"
    echo -e "\nExamples:"
    echo -e "\t- Install both   : ./setup.sh parse splunk"
    echo -e "\t- Install parser : ./setup.sh parse"
    echo -e "\t- Install splunk : ./setup.sh splunk\n"
    exit 1
fi

# Notify user. Script completed execution
echo -e "\n[$(date '+%d/%m/%Y %H:%M:%S')]: Done!\n"
