#!/bin/bash

# Elevate session
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

# Flags and argument init
valid_arg=false
invalid_arg_found=false
invalid_args=""

# Execute setup scripts based on provided arguments
for arg in "$@"; do
    case "$arg" in
        parse)       
            echo -e "\nExecuting ./parse/setup.sh..."
            cd parse || exit 1 # Exit if directory change fails
            chmod +x ./setup.sh
            ./setup.sh
            cd .. # Return to the original directory
            valid_arg=true
            ;;
        splunk) 
            echo -e "\nExecuting ./splunk/setup.sh..."
            cd splunk || exit 1
            chmod +x ./setup.sh
            ./setup.sh
            cd ..
            valid_arg=true
            ;;
        timesketch) 
            echo -e "\nExecuting ./timesketch/setup.sh..."
            cd timesketch || exit 1
            chmod +x ./setup.sh
            ./setup.sh
            cd ..
            valid_arg=true
            ;;
        *)
            # If the argument doesn't match any case
            invalid_arg_found=true
            invalid_args="$invalid_args '$arg'"
            ;;
    esac
done

# ---

## Error Handling and Help Page

# Check for invalid arguments first
if [ "$invalid_arg_found" = true ]; then
    echo -e "\nWarning : The following arguments were ignored as they are not valid options: $invalid_args"
fi

# Check if ANY valid action was taken. If not, display the help message.
if [ "$valid_arg" = false ]; then
    echo -e "\nError   : No valid script arguments passed! Specify one or more to install corresponding module."
    echo -e "Options : 'parse', 'splunk', 'timesketch'"
    echo -e "\nExamples:"
    echo -e "\t- Install multiple  : ./setup.sh parse splunk timesketch"
    echo -e "\t- Install parser    : ./setup.sh parse"
    echo -e "\t- Install splunk    : ./setup.sh splunk\n"
    exit 1
fi

# Notify user. Script completed execution
echo -e "\n[$(date '+%d/%m/%Y %H:%M:%S')]: Done!\n"
