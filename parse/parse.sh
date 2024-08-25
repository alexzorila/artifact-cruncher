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
        basename=$(basename $filename .zip)
        datetime=$(date -d "today" +"%Y%m%d%H%M")
        workdir="/tmp/$datetime"
        hostdir=$PWD/$datetime
        mkdir $workdir $hostdir $workdir/MFT

        # Switch context to WSL file system
        cp $filename $workdir
        cd $workdir


        ### Create Timeline ###

        # Get MFT file name(s)
        mftfiles=$(unzip -l $filename | grep -i mft | awk '{print $4}')
        
        # For each MFT file
        for mft in $mftfiles; do
            # Get drive letter
            drive=$(echo $mft | grep -oP '(?<=%5C%5C.%5C).*(?=%3A/\$MFT)')
            # Extract MFT
            unzip -o -j $filename $mft -d $workdir
            # Parse MFT to body file
            MFTECmd -f $workdir/\$MFT --body $workdir/MFT --bodyf $drive.mft.body --bdl $drive
            rm -rf \$MFT
            # Parse body file to CSV Timeline
            mactime -b $workdir/MFT/$drive.mft.body -d -y -z UTC > $workdir/MFT/$drive.MftTimeline.csv
        done
        
        # Merge MFT CSV file(s) Timeline
        awk 'NR == 1 || FNR > 1' $workdir/MFT/*.csv > $workdir/MftTimeline.csv


        ### Create Supertimeline ###

        # Parse Triage image to Plaso file, excluding MFT
        # docker run --rm -v .:/data log2timeline/plaso \
        #        log2timeline --parsers \!mft \
        #        --storage_file /data/$basename.plaso /data/$filename

        ### Below section commented for parsing speed ###
        # Merge MFT bodyfile(s) with Triage image Plaso
        # docker run --rm -v .:/data log2timeline/plaso \
        #        log2timeline -z UTC --parsers mactime \
        #        --storage_file /data/$basename.plaso /data/MFT

        # Convert Plaso to CSV
        # docker run --rm -v .:/data log2timeline/plaso \
        #        psort -w /data/$basename.csv /data/$basename.plaso

        # Cleanup
        mv -f $workdir/*.csv "$hostdir"
        # rm -rf $workdir
        exit 0
  ;;
  n|N) echo -e "No selected. Exiting.\n"
        exit 1
  ;;
  *) echo -e "Invalid choice. Please answer y or n.\n"
        exit 1
  ;;
esac
