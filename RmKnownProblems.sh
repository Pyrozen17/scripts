#!/bin/bash

echo -e "Would you like to remove some of the known vulerabilities from this machine? i.e. netcat, telnet, etc."
read RmKnownResponse
check(){
if [ $RmKnownResponse = "n" ]
then
	echo "Good Luck"
    	exit
elif [ $RmKnownResponse = "Y" ]
then
    	declare -a vulnList=('netcat' 'nc' 'telnet' 'telnetd inetulis-telnethd telnetd-ssl' 'john'
    	'johntheripper' 'rshd' 'rwhod' 'wu-ftpd' 'wu-ftp' 'sendmail' 'rpc' 'lpd' 'nfs' 'nfsd'
    	'lockd' 'mountd' 'statd' 'portmapper' 'vsftpd'); #List of known vulnerabilities.

	echo -e "Now let's remove some known problems... i.e netcat and john"

	for v in "${vulnList[@]}"
	do
		apt-get purge $v -y --force-yes
	done

	echo -e "Done! Time to remove leftover files from these."

	apt-get autoremove -y --force-yes #Autoremove residual files.
else
	echo "Please type 'Y' or 'n':"
	read response
	check
fi
}
check

