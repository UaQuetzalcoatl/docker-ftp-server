#! /bin/bash

set -e

if [[ ! -z "$FTP_LOGIN" &&  ! -z "$FTP_PASSWORD" ]]; then
    
    if id "$FTP_LOGIN" >/dev/null 2>&1; then
        userdel -fr $FTP_LOGIN
    fi
    
    echo "Adding a new FTP user"
    useradd -m -g ftpaccess -s /bin/sh -d /home/$FTP_LOGIN $FTP_LOGIN
    echo -e "$FTP_PASSWORD\n$FTP_PASSWORD" | passwd $FTP_LOGIN
    chown $FTP_LOGIN:ftpaccess /home/$FTP_LOGIN

else
    echo "Info: FTP_LOGIN environment or FTP_PASSWORD variable is NOT set, skipping adding a new user"
fi

proftpd -n