#!/bin/bash

# Usage tips:
# 1) In addition to VPN credentials, you will be prompted for the OS/system
#    password for sudo.
# 2) One user has reported that the script will sometimes say it's connected,
#    but doesn't seem to actually connect. Run it again and it'll work.

ENDPOINT='VPNHostNameHere' # Example: vpn.yourhost.com
HOSTNAME="SomeHostNameOnlyonVPN" #Example: mydomain.yourhost.com
OPENCONNECT=$(which openconnect)
VPN_SLICE=$(which vpn-slice)

#read -p 'EUA Username: ' USER
#read -rsp 'VPN Password: ' PW
#echo
USER=UserIDHere # Example: YTFG
PW=PasswordHere # Example: ypNe#TNAu8awZU84j2CC
#TOKEN=$(gauth token my-token) If you are using: https://github.com/faraazkhan/gauth
# Or read it from STDIN if you are using phone
read -p 'MFA Token: ' TOKEN

if [ -z "${USER}" -o -z "${PW}" -o -z "${TOKEN}" ]; then
  echo >&2 "error: username, password, and token must be provided"
  exit 1
fi

printf "%s\n%s\ny" "${PW}" "${TOKEN}" | sudo ${OPENCONNECT} ${ENDPOINT} \
    --passwd-on-stdin \
    -m 1290 \
    -u ${USER} \
    -s "${VPN_SLICE} \
    10.0.0.0/8 \
    <other hostnames> \
    " &

sleep 10s &&
echo "Keeping connection alive by pinging ${HOSTNAME} every 15 seconds" &&
watch -n 90 nc -vz ${HOSTNAME} 443 &&
kill $! # terminate both processes at once
