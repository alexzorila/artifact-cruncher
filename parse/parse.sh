#!/bin/bash

# Require elevation
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

# Check if script has at least one argument
if [[ $# -lt 2 ]] ; then
    echo -e "\nNo parameter passed!\n\tPlease use -f or --filename followed by a full path.\n\tEg: parse.sh -f DESKTOP-123.zip\n"
    exit 1
fi

# Read script arguments to store filename to be parsed
while [[ $# -gt 0 ]]
do case $1 in
    -f|--filename) filename="$2"
    shift;;
    *) echo -e "\nUnknown parameter passed: $1\n\tPlease use -f or --filename followed by a full path.\n\tEg: parse.sh -f DESKTOP-123.zip\n"
    exit 1;;
esac
shift
done

# Check if filename exists
if [ ! -f $filename ]; then
    echo -e "\nFile $filename not found!\nExiting..\n"
    exit 1
else
    echo -e "\nFile to be parsed: $filename"
fi

# Confirm user choice
read -p "Continue (y/y)? " choice
case "$choice" in
  y|Y)
        # Set unique values for work directory naming
        datetime=$(date -d "today" +"%Y%m%d%H%M")
        workdir="/tmp/$datetime"
        hostdir=$PWD/$datetime
        
        # Create work directories
        mkdir $workdir $hostdir
        
        # Switch context to WSL file system
        cp $filename $workdir
        cd $workdir

        
        #### Create Timeline ####
        
        # Create MFT work dir
        mkdir $workdir/mft
        
        # Get list of MFT files
        mftfiles=$(unzip -l $filename | grep -i mft | awk '{print $4}')
        
        # Parse each MFT file in the list to CSV Timeline
        for mft in $mftfiles; do
            # Get drive letter
            drive=$(echo $mft | grep -oP '(?<=%5C%5C.%5C).*(?=%3A/\$MFT)')
            # Extract MFT
            unzip -o -j $filename $mft -d .
            # Parse MFT to body file
            MFTECmd -f \$MFT --body mft --bodyf $drive.mft.body --bdl $drive
            rm -rf \$MFT
            # Parse body file to CSV Timeline
            mactime -b mft/$drive.mft.body -d -y -z UTC > mft/$drive.MftTimeline.csv
        done
        
        # Merge CSV Timeline
        awk 'NR == 1 || FNR > 1' MFT/*.csv > MftTimeline.csv
        
        # Cleanup
        mv -f MftTimeline.csv "$hostdir"
        rm -rf mft


        #### Create Supertimeline ####
        
        # Create files work dir
        mkdir $workdir/files
        
        # Expand triage collection
        unzip $filename -d expand
        
        # Cleanup 
        mv ./expand/uploads/* ./files
        rm -rf expand $filename
        
        # Parse triage collection to CSV Supertimeline, excluding MFT
        docker run --rm -v .:/data log2timeline/plaso \
            psteal --parsers \!mft --hashers none --archives none \
            --source /data/files -w /data/Supertimeline.csv

        # Cleanup
        mv -f Supertimeline.csv "$hostdir"
        rm -rf $workdir
        exit 0
  ;;
  n|N) echo -e "No selected. Exiting.\n"
        exit 1
  ;;
  *) echo -e "Invalid choice. Please answer y or n.\n"
        exit 1
  ;;
esac
