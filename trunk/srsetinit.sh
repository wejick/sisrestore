#! /bin/sh
###Begin Info
# Name : srsetinit
# Short-Description : prepare the work mode of SR
# Author / Copyright : Gian Giovani <wejick@gmail.com> wejick.wordpress.com
# License : GPL
### END Info

. /etc/sisrestore.conf

if [ $bsdmod -eq 0 ]; then
	chmod 744 $INITPATH/sisrestore
	if [ $wmode -eq 1 ]; then
		if [ -x /etc/rcS.d/S38sisrestore ]; then
			mv /etc/rcS.d/S38sisrestore /etc/rcS.d/K38sisrestore
		fi
		if [ -r /etc/rc0.d/K01sisrestore ]; then
			mv /etc/rc0.d/K01sisrestore /etc/rc0.d/S01sisrestore
		fi
		if [ ! -x /etc/rc0.d/S01sisrestore ]; then
			chmod 744 /etc/rc0.d/S01sisrestore
		fi
	elif [ $wmode -eq 2 ]; then
		if [ -x /etc/rc0.d/S01sisrestore ]; then
			mv /etc/rc0.d/S01sisrestore /etc/rc0.d/K01sisrestore
		fi
		if [ -r /etc/rcS.d/K38sisrestore ]; then
			mv /etc/rcS.d/K38sisrestore /etc/rcS.d/S38sisrestore
		fi
		if [ ! -x /etc/rcS.d/S38sisrestore ]; then
			chmod 744 /etc/rcS.d/S38sisrestore
		fi
	elif [ $wmode -eq 3 ]; then
		if [ -x /etc/rcS.d/S38sisrestore ]; then
			mv /etc/rcS.d/S38sisrestore /etc/rcS.d/K38sisrestore
		fi
		if [ -x /etc/rc0.d/S01sisrestore ]; then
			mv /etc/rc0.d/S01sisrestore /etc/rc0.d/K01sisrestore
		fi
	else
		echo "$(date +%F===%H:%m:%S) Operation failed. See documentation. Init script setup failure" >> $log_file
		echo "Operation failed. See documentation. Init script setup failure"
	fi
elif [ $bsdmod -q 1 ]; then
	if [ $wmode -eq 1 ]; then
		if [ -x /etc/rc.d/sisrestore ]; then
			chmod 744 /etc/rc.d/sisrestore
		fi
	elif [ $wmode -eq 2 ]; then
		if [ -x /etc/rc.d/sisrestore ]; then
			chmod 744 /etc/rc.d/sisrestore
		fi
	elif [ $wmode -eq 3 ]; then
		if [ -x /etc/rc.d/sisrestore ]; then
			chmod 644 /etc/rc.d/sisrestore
		fi
	else
		echo "$(date +%F===%H:%m:%S) Operation failed. See documentation. Init script setup failure" >> $log_file
		echo "Operation failed. See documentation. Init script setup failure"
	fi

else
	echo >> "$(date +%F===%H:%m:%S) SR did not understand value of bsdmod" >> $log_file
fi
