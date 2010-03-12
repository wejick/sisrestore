#! /bin/sh
###Begin Info
# Name : Sisrestore
# Required software : tar, lzma
# Short-Description : Make deepfreezed like system
# Author / Copyright : Gian Giovani <wejick@gmail.com> wejick.wordpress.com
# License : GPL
### END Info

PATH="/:$PATH"; export PATH

. /etc/sisrestore.conf

# Function
stat_en() {
	echo "ENABLED" > $status_file
	echo "Backup file : $(ls -l $srpath | grep kodinbak)" >> $status_file
	echo "Work mode : $wmode" >> $status_file
	echo "Action Mode : $amode" >> $status_file
	echo "target : $target" >> $status_file
}
do_res() {
	if [ -r $srpath/kodinbak.tar ] || [ -r $srpath/kodinbak.tar.lzma ]; then
		rm -rf $target
	else 
		echo "$(date +%F===%H:%m:%S) You must create backup file before. See the documentation" >> $log_file
		echo "You must create backup file before. See the documentation"
	fi

	rsarchive
}
# Function switcher
# Make Archive
if [ $amode -eq 1 ]; then
	mkarchive() {
		cd /
		tar -cf kodinbak.tar $target
		mv /kodinbak.tar $srpath
			if [ $? -eq 0 ]; then
				echo "$(date +%F===%H:%m:%S) backup file created" >> $log_file
				echo "		$(ls -a $srpath/kodinbak.tar)" >> $log_file
			else
				echo "$(date +%F===%H:%m:%S) failed to create backup file" >> $log_file
			fi

		}
elif [ $amode -eq 2 ]; then
		mkarchive() {
		cd /
		tar --lzma -cf kodinbak.tar.lzma $target
		mv /kodinbak.tar.lzma $srpath
			if [ $? -eq 0 ]; then
				echo "$(date +%F===%H:%m:%S) backup file created" >> $log_file
				echo "		$(ls -a $srpath/kodinbak.tar.lzma)" >> $log_file
			else
				echo "$(date +%F===%H:%m:%S) failed to create backup file" >> $log_file
			fi
		}
else
	echo "$(date +%F===%H:%m:%S) Archive Mode not supported" >> $log_file
	echo "Archive Mode not supported"
fi

# Restore Archive
if [ $amode -eq 1 ]; then
	rsarchive() { 
		cd /
		tar -xf $srpath/kodinbak.tar
		}
elif [ $amode -eq 2 ]; then
		rsarchive() {
		cd /
		tar --lzma -xf $srpath/kodinbak.tar.lzma
		}
else
	echo "$(date +%F===%H:%m:%S) Archive Mode not supported" >> $log_file
	echo "Archive Mode not supported"
fi

###Text ui###
# Act as text ui
# May I separate it?

if [ "$1" = "enable" ]; then
	mkarchive
	ls -l $srpath | grep kodinbak
	sh /usr/share/kompudini/sr/srsetinit.sh
	stat_en
elif [ "$1" = "disable" ]; then
	rm -rf $srpath/kodinbak.ta*
	ls -l $srpath | grep kodinbak
	echo "DISABLED" > $status_file
	chmod -x /$INITPATH/sisrestore
elif [ "$1" = "reload" ]; then
	sh /usr/share/kompudini/sr/srsetinit.sh
	stat_en
elif [ "$1" = "restore" ]; then
	do_res
	echo "Working"
	sleep 3
	echo "finnish"
elif [ "$1" = "help" ]; then
	cat /usr/share/kompudini/sr/srhelp
else
	echo "try help"
fi
