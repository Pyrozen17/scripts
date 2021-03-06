#!/bin/bash

Purple='\033[0;35m'
NC='\033[0m'
echo -e "Would you like to go through services now?"
read servicesInput
check(){
if [ $servicesInput = "n" ]
then
	echo -e "Lets continue"
elif [ $servicesInput = "Y" ]
then
	declare -a removeList=(); #List of things to be removed
	declare -a vulnList=('ftp' 'vsftpd' 'bind9' 'smba' 'samba' 'sambashare' 'smbashare' 'apache' 'dnsmasq' 'bind9' 'apache' 	'apache2' ); #List of services

	for x in "${vulnList[@]}" 
	do
		echo -e "Do you need $x?" #Prompt if the service is needed.
		read response
		if [ $response = "n" ]
		then
    			removeList+=("$x") #Add service to be removeList.
		fi
	done

	echo -e "Ok. Lets remove them."
	for z in "${removeList[@]}" #Purge everything in the removeList.
	do
		apt-get purge $z -y --force-yes 
	done

	apt-get autoremove -y --force-yes #Clean up residual files.

else
	echo -e "Please type 'Y' or 'n':"
	read servicesInput
	check
fi
}
check



