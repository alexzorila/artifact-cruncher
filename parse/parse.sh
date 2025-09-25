#!/bin/bash

# Require elevation
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

# Check if script has at least one argument
if [[ $# -lt 2 ]] ; then
    echo -e "\nNo parameter passed!\n\tPlease use -f or --filename followed by a full path.\n\tEg: parse -f DESKTOP-123.zip\n"
    exit 1
fi

# Read script arguments to store filename to be parsed
while [[ $# -gt 0 ]]
do case $1 in
    -f|--filename) filename="$2"
    shift;;
    *) echo -e "\nUnknown parameter passed: $1\n\tPlease use -f or --filename followed by a full path.\n\tEg: parse -f DESKTOP-123.zip\n"
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
        # Notify user
        echo -e "\nProcessing File ...\n"

        # Set up work directory
        hostname=$(echo $filename | grep -oP '(?<=Collection-).*(?=-\d{4}-\d{2}-\d{2}T\d{2}_\d{2}_\d{2}Z)')
        datetime=$(date -d "today" +"%Y%m%d%H%M")
        workdir="/tmp/$hostname/$datetime"
        hostdir="$PWD/$hostname/$datetime"
        mkdir -p "$workdir" "$hostdir"
        cp $filename $workdir
        cd $workdir

        ########################## Create Timeline ############################

        # Create MFT timeline work directory
        mkdir mft

        # Get MFT file names from collection
        mftfiles=$(unzip -l $filename | grep \$MFT | awk '{print $4}')

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
            echo -e "\nParsing MFT to Timeline ..."
            mactime -b mft/$drive.mft.body -d -y -z UTC > mft/$drive.MftTimeline.csv
        done

        # Merge CSV Timeline
        awk 'NR == 1 || FNR > 1' mft/*.csv > MftTimeline.csv

        # Move CSV to host
        mv -f MftTimeline.csv "$hostdir" && rm -rf mft

        # Notify user
        echo -e "\nDone!\n"


        ######################### Create Supertimeline ########################

        # Create Plaso data source directory
        mkdir files

        # Expand triage collection and remove extra files
        unzip $filename -d exp && mv ./exp/uploads/* ./files && rm -rf exp $filename

        # Parse triage collection to Plaso, excluding MFT
        docker run --rm -v .:/data log2timeline/plaso:20240826 \
            log2timeline \
            --parsers \!mft,\!onedrive_log --hashers none --archives none \
            --storage-file /data/Supertimeline.plaso /data/files
        
        # Parse Plaso to CSV Supertimeline, excluding MFT
        docker run --rm -v .:/data log2timeline/plaso:20240826 \
            psort -w /data/Supertimeline.csv /data/Supertimeline.plaso

        # Move Plaso, CSV to host
        mv -f Supertimeline.plaso Supertimeline.csv "$hostdir" && rm -rf $workdir

        # Notify user
        echo -e "\nCSV Output:\n$hostdir/MftTimeline.csv\n$hostdir/Supertimeline.(plaso|csv)"

        # Display parsing run time
        echo -e "\nRun time: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec\n"
        exit 0
  ;;
  n|N) echo -e "No selected. Exiting.\n"
        exit 1
  ;;
  *) echo -e "Invalid choice. Please answer y or n.\n"
        exit 1
  ;;
esac
