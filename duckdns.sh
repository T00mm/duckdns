#!/bin/bash

EXITCODE=0

echo 'Updating DuckDNS entries... '

for file in /etc/duckdns.d/*.cfg
do
	source "${file}"
	echo -n "Executing config file '${file}': "
	OUTPUT=$(curl -k -s "https://www.duckdns.org/update?domains=${duckdns_hostname}&token=${duckdns_token}&ip=")
	echo ${OUTPUT}

	if [ "${OUTPUT}" == "KO" ]; then
		EXITCODE=1
	fi
done

exit $EXITCODE
