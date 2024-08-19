#!/bin/bash

# Skip Splunk Tour
echo -e "[default]\nuseTour = false" > /opt/splunk/etc/system/local/ui-tour.conf

# Disable 'Help us improve Splunk' user prompt
mkdir -p /opt/splunk/etc/users/admin/user-prefs/local/
echo -e "[general]\ndismissedInstrumentationOptInVersion = 4" > /opt/splunk/etc/users/admin/user-prefs/local/user-prefs.conf
  
# Set default App Web GUI opens
mkdir -p /opt/splunk/etc/apps/user-prefs/local/
echo -e "[general_default]\ndefault_namespace = search" > /opt/splunk/etc/apps/user-prefs/local/user-prefs.conf
	
# Set default index search to any
echo -e "[role_admin]\nsrchIndexesDefault = *" > /opt/splunk/etc/system/local/authorize.conf

# Increase MAX_DAYS_AGO to allow for old timestamps to be parsed
echo -e "[default]\nMAX_DAYS_AGO = 10951" > /opt/splunk/etc/system/local/props.conf
# Source: https://docs.splunk.com/Documentation/Splunk/9.0.3/Admin/Propsconf#Timestamp_extraction_configuration

# Create index for forensic data
/opt/splunk/bin/splunk add index forensics -auth admin:Passw0rd!

# Configure data ingestion sources
echo '[monitor:///home/splunk/data]
disabled = false
host = splunklocal
index = forensics
crcSalt = <SOURCE>' > /opt/splunk/etc/apps/search/local/inputs.conf
