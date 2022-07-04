#!/bin/bash
# set -euxo pipefail # Print any command beore executing.
set -euo pipefail # Print any command beore executing.

if (( EUID != 0 )); then
    echo "Please run as root."
    exit
fi

##
# Variables
#
JNI_AUTOMATION_STRING="## JNI AUTOMATION MARKER"
HOSTS_SRC="./hosts"
HOSTS_TEMP="./hosts.temp"
HOSTS_TARGET="/etc/hosts"


##
# Main
#
clear
printf ">>>UPDATING HOSTS<<<\n\n"

printf "Checking system file with hosts..."
if ! grep "$JNI_AUTOMATION_STRING" "$HOSTS_TARGET" >/dev/null ;
then
	printf "\nPlease provide an existing hosts file with the following string in it: %s" "$JNI_AUTOMATION_STRING"
	exit 9
fi
printf "OKAY\n"

#
# (1) Take the first part of the system hosts file for creating a temorary file
#
# "grep -Fn" delivers the line number of the matching string: (eg. "7:## JNI AUTOMATION MARKER")
line_number_target=$(grep -Fn "$JNI_AUTOMATION_STRING" "$HOSTS_TARGET" | cut -d':' -f1)
line_number_target=$(( line_number_target -1 ))
# "sed 11q filename" prints the 11 lines of the file with filename. 
sed "$line_number_target"q "$HOSTS_TARGET" > $HOSTS_TEMP

#
# (2) Use the second part from the repo hosts file with fresh hosts information
#
line_number_source=$(grep -Fn "$JNI_AUTOMATION_STRING" "$HOSTS_SRC" | cut -d':' -f1)
param="$line_number_source,$ !d"
cat "$HOSTS_SRC" | sed "$param" >> $HOSTS_TEMP

#
# (3) Backup old system hosts file and replace with updated file.
#
rm -f "$HOSTS_TARGET".backup
BACKUP_FILEPATH="${HOSTS_TARGET}.backup"
cp "$HOSTS_TARGET" "$BACKUP_FILEPATH"
echo "Backup file has been written to $BACKUP_FILEPATH"
rm -f "HOSTS_TARGET"
mv $HOSTS_TEMP $HOSTS_TARGET

echo "System host file has been updated!"

exit 0
