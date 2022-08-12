#!/bin/bash

usage()
{
        echo "-d  dry-run mode"
}

DRYRUN=

while getopts 'dh' option
do
        case $option in
                d)
                        DRYRUN=y
                        ;;
                h|?)
                        usage
                        exit 2
                        ;;
        esac
done


declare -A OMNI STARTUPCACHE

omni_ja="/c/Program Files/Mozilla Firefox Beta/browser/omni.ja"
if [ -e "$omni_ja" ]; then
	startupcache="/c/Users/morgan.chang/AppData/Local/Mozilla/Firefox/Profiles/6qja40ki.default-beta/startupCache/startupCache.8.little"
	if [ -e "$startupcache" ]; then
		OMNI['vtx-morgan-beta']="$omni_ja"
		STARTUPCACHE['vtx-morgan-beta']="$startupcache"
	fi
fi

omni_ja="/c/Program Files/Firefox Developer Edition/browser/omni.ja"
if [ -e "$omni_ja" ]; then
	startupcache="/c/Users/morgan.chang/AppData/Local/Mozilla/Firefox/Profiles/y5s71ffn.morgan-Developer/startupCache/startupCache.8.little"
	if [ -e "$startupcache" ]; then
		OMNI['vtx-morgan-developer']="${omni_ja}"
		STARTUPCACHE['vtx-morgan-developer']="$startupcache"
	fi
fi


omni_ja="/c/Users/morgan/AppData/Local/Firefox Developer Edition/browser/omni.ja"
if [ -e "$omni_ja" ]; then
	startupcache="/c/Users/morgan/AppData/Local/Mozilla/Firefox/Profiles/ge0idutt.default-beta/startupCache/startupCache.8.little"
	if [ -e "$startupcache" ]; then
		OMNI['orion-developer']="${omni_ja}"
		STARTUPCACHE['orion-developer']="$startupcache"
	fi
fi

omni_ja="/c/Program Files/Firefox Nightly/browser/omni.ja"
if [ -e "$omni_ja" ]; then
	startupcache="/c/Users/morgan/AppData/Local/Mozilla/Firefox/Profiles/bjhk9f3k.Nightly/startupCache/startupCache.8.little"
	if [ -e "$startupcache" ]; then
		OMNI['orion-nightly']=${omni_ja}
		STARTUPCACHE['orion-nightly']="$startupcache"
	fi
	startupcache="/c/Users/morgan.chang/AppData/Local/Mozilla/Firefox/Profiles/k4balfyj.morgan-nightly/startupCache/startupCache.8.little"
	if [ -e "$startupcache" ]; then
		OMNI['vtx-morgan-nightly']=${omni_ja}
		STARTUPCACHE['vtx-morgan-nightly']="$startupcache"
	fi
fi

omni_ja="/usr/lib/firefox/browser/omni.ja"
if [ -e "$omni_ja" ]; then
	startupcache="/home/morgan/.cache/mozilla/firefox/47f7vds8.default/startupCache/startupCache.8.little"
	if [ -e "$startupcache" ]; then
		OMNI['aries']=${omni_ja}
		STARTUPCACHE['aries']="$startupcache"
	fi
fi

echo ==============================================
echo Environments of omni.ja : ${!OMNI[@]}
echo ==============================================
echo Paths of omni.ja : ${OMNI[@]}
echo ==============================================
echo startupCache : ${STARTUPCACHE[@]}
echo ==============================================
[ x"$DRYRUN" != x ] && exit


for k in "${!OMNI[@]}"; do
	if [ -e "${OMNI[$k]}" ]; then
		rm -rf omni *.zip
		mkdir -p omni
		cp "${OMNI[$k]}" ./

		[ -x /c/Program\ Files/7-Zip/7z.exe ] \
			&& UNZIP=/c/Program\ Files/7-Zip/7z.exe  OPT='x -oomni' \
			|| UNZIP=unzip OPT='-d omni'
		"$UNZIP" $OPT omni.ja
		sed -i -e '/<key id="key_privatebrowsing"/{ N; s/accel,shift/accel,alt,shift/}' \
			omni/chrome/browser/content/browser/browser.xhtml

		which zip &> /dev/null && ZIP=zip OPT="-r" || ZIP=/c/Program\ Files/7-Zip/7z.exe OPT='a'
		cd omni && "$ZIP" $OPT ../omni.ja.zip *
		cd ..
		rm -f "${OMNI[$k]}"
		cp omni.ja.zip "${OMNI[$k]}"

		rm -f "${STARTUPCACHE[$k]}"
	fi
done
