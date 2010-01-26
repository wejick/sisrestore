#! /bin/sh

if [ ! $(whoami) = "root" ]; then
	echo "I need run as root account"
	exit
fi
if [ "$1" = "install" ]; then
	cp ./SistemRestore.sh /usr/sbin/
	chmod 744 /usr/sbin/SistemRestore.sh
	ln -s /usr/sbin/SistemRestore.sh /usr/sbin/sisrestore
	chmod 744 /usr/sbin/sisrestore
	
	cp ./xsr /usr/sbin
	chmod 744 /usr/sbin/xsr

	cp ./sisrestore /etc/init.d/
	chmod 744 /etc/init.d/sisrestore
	ln -s /etc/init.d/sisrestore /etc/rcS.d/S38sisrestore
	chmod 444 /etc/init.d/sisrestore /etc/rcS.d/S38sisrestore
	ln -s /etc/init.d/sisrestore /etc/rc0.d/S01sisrestore
	chmod 444 /etc/rc0.d/S01sisrestore

	mkdir /var/kompudini/
	chmod -R 755 /var/kompudini
	mkdir /var/kompudini/sr
	chmod -R 755 /var/kompudini
	touch /var/kompudini/sr/sisrestore.log
	chmod 666 /var/kompudini/sr/sisrestore.log
	touch /var/kompudini/sr/status
	chmod 666 /var/kompudini/sr/status
	chmod -R 777 /var/kompudini/sr/
	
	mkdir /usr/share/kompudini
	chmod -R 755 /usr/share/kompudini
	mkdir /usr/share/kompudini/sr
	chmod -R 755 /usr/share/kompudini/sr
	cp ./srsetinit.sh /usr/share/kompudini/sr/
	chmod 744 /usr/share/kompudini/sr/srsetinit.sh
	cp ./srhelp /usr/share/kompudini/sr/
	chmod 644 /usr/share/kompudini/sr/srhelp
	cp ./setup.sh /usr/share/kompudini/sr/
	chmod 744 /usr/share/kompudini/sr/setup.sh
	cp ./documentation.html /usr/share/kompudini/sr/
	chmod 744 /usr/share/kompudini/sr/documentation.html
	cp ./handbook.css /usr/share/kompudini/sr/
	chmod 744 /usr/share/kompudini/sr/handbook.css
	
	cp ./sisrestore.conf /etc/
	chmod 644 /etc/sisrestore.conf
	cp ./sr.desktop /usr/share/applications
	chmod 777 /usr/share/applications/sr.desktop
	ln /usr/share/applications/sr.desktop /home/*/Desktop
	echo "Enable SistemRestore .."
	sisrestore enable
	echo "Install Finish"
elif [ "$1" = "uninstall" ]; then
	rm -rfv /usr/sbin/SistemRestore.sh
	rm -rfv /usr/sbin/sisrestore
	rm -rfv /usr/sbin/xsr
	rm -rfv /etc/init.d/sisrestore
	rm -rfv /etc/rcS.d/S38sisrestore || rm -rf /etc/rcS.d/K38sisrestore
	rm -rfv /etc/rc0.d/S01sisrestore || rm -rf /etc/rc0.d/K01sisrestore
	rm -rfv /var/kompudini/sr
	rm -rfv /usr/share/kompudini/sr
	rm -rfv /etc/sisrestore.conf
	rm -rfv /usr/share/applications/sr.desktop
	rm -rfv /home/*/Desktop/sr.desktop
	echo "Uninstall Finish"
else
	echo "install | uninstall"
fi
