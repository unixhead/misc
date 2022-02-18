#!/bin/bash
#submits hdparm status for disk to influxdb to monitor when they're sleeping


INFLUXTOKEN="<INFLUX_API_TOKEN_HERE>"
INFLUXURL="<INFLUX_URL_HERE>"
#CURLOPTS: set to -v for debugging
# --cacert /path/to/cert to use a private PKI and HTTPS
CURLOPTS="" 

HOST=`hostname`

#tag the location for InfluxDB
HOSTLOCATION="Network_Rack" 


#Get sleep status of sdc
SDCSTAT=`/sbin/hdparm -C /dev/sdc | grep "drive state" | awk '{print $4}'`
if [ "$SDCSTAT" = "standby" ]; then
	SDCSLEEP=1
else
	SDCSLEEP=0
fi

#Get sleep status of sdd
SDDSTAT=`/sbin/hdparm -C /dev/sdd | grep "drive state" | awk '{print $4}'`
if [ "$SDDSTAT" = "standby" ]; then
        SDDSLEEP=1 
else
        SDDSLEEP=0
fi

#Format: measurement,tags values
OUTPUT="pimeasure,host=${HOST},location=${HOSTLOCATION} sdcsleep=${SDCSLEEP},sddsleep=${SDDSLEEP}"


curl ${CURLOPTS} -H 'Content-Type: text/plain' --request POST  "${INFLUXURL}" \
  --header "Authorization: Token ${INFLUXTOKEN}" \
  --data-binary "${OUTPUT}"

