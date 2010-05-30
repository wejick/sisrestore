#for guided 
which zenity
if [ ! $? -eq 0 ]; then
	exit 1
fi
#Installation wizard
wm() {
	#Define Wmode
	xmessage -title "Sisrestore Install Wizard - Wmode" -buttons "At Shutdown (1)":3,"At boot (2)":4,"On Demand (3)":5,"Exit":11 \
	-center "When sisrestore reset your directory? (work mode)"
	temp=$? #to catch $? value right now
	if [ $temp -eq 11 ]; then
		exit 0
	else 
	wmo=$(($temp-2))
	echo $wmo
	am #next to am()
	fi

	}
	#Define Amode
am() {
	xmessage -title "Sisrestore Install Wizard - Amode" -buttons "Tar":3,"Tar LZMA":4,"Back":10,"Exit":11 \
	-center "How sisrestore save your backup? (Archive mode)"
	temp=$? #to catch $? value right now
	if [ $temp -eq 11 ]; then
		exit 0
	elif [ $temp -eq 10 ]; then
		echo "back"
		wm #back to wm()
	else
	amo=$(($temp-2))
	echo $amo
	bm #next to  bm()
	fi
	}
	#Define BSD Mode
bm() {
	xmessage -title "Sisrestore Install Wizard - BSDMode" -buttons "No":2,"Yes":3,"Back":10,"Exit":11 \
	-center "Is it BSD or Slackware Machine ? (BSDMode)"
	temp=$? #to catch $? value right now
	if [ $temp -eq 11 ]; then
		exit 0
	elif [ $temp -eq 10 ]; then
		echo "back"
		am	#back to am
	else 
		bmo=$(($temp-2))
		echo $bmo
		tgt #next to tgt
	fi
	}
tgt() {
	xmessage -title "Sisrestore Install Wizard - Target" -buttons "Choose":3,"Back":10,"Exit":11 \
	-center "Define target directory ? (Target)"
	temp=$?
	if [ $temp -eq 3 ]; then
		tar=$(zenity --title "SistemRestore Configuration" --file-selection --directory --text "Define the target")
	elif [ $temp -eq 11 ]; then
		exit 0
	elif [ $temp -eq 10 ]; then
		echo "back"
		bm	#back to bm
	fi
	}

xmessage -title "Sisrestore Install Wizard" -buttons "Yes":2,"No":11 -center "Do you want to continue installation?"
if [ $? -eq 2 ]; then
	wm #call wm
else 
	exit 0
fi

echo "wmode="$wmo"
amode="$amo"
target="$tar"
srpath=/var/kompudini/sr
log_file=/var/kompudini/sr/sisrestore.log
status_file=/var/kompudini/sr/status
bsdmod="$bmo"

# INITPATH
if [ \$bsdmod -eq 0 ]; then
	INITPATH=/etc/init.d
elif [ \$bsdmod -eq 1 ]; then
	INITPATH=/etc/rc.d
fi
# END OF INITPATH DECLARATION
" > ./sisrestore.conf

#execute installer
if [ $bmo -eq 1 ]; then
	sh -x ./setup.sh install bsd
else
	sh -x ./setup.sh install
fi

