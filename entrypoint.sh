#!/bin/sh

# Script to setup a cron job to update the IP address of a domain in dondominio.com
# The script requires the following environment variables:
# - UTIME: Time to wait between updates in minutes, hours or days (e.g. 5m, 1h, 1d)

# Check if the PTIME environment variable is set
if [ -z "$UTIME" ] ; then
    echo "The environment variable PTIME is not set. Using default value of 5 minutes"
    UTIME="5m"
fi

# Parse the time to wait between updates in a format that cron understands
case "$UTIME" in
    *m) 
        UTIME="${UTIME%?}"
        CRON_TIME="*/$UTIME * * * *"
        ;;
    *h) 
        UTIME="${UTIME%?}"
        CRON_TIME="0 */$UTIME * * *"
        ;;
    *d) 
        UTIME="${UTIME%?}"
        CRON_TIME="0 0 */$UTIME * *"
        ;;
    *) 
        echo "The time to wait between updates is not in a valid format. Using default value of 5 minutes"
        CRON_TIME="*/5 * * * *"
        ;;
esac

# Execute the script once to update the IP address
/app/run.sh

# Create a cron job to run the script
echo "$CRON_TIME /app/run.sh" > /etc/crontabs/root

# Run the cron daemon in first plane
crond -f -l 8 -L /dev/stdout

# The UTIME accepts the following formats:
# - 5m: 5 minutes
# - 1h: 1 hour
# - 1d: 1 day
