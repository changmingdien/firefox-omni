#!/bin/sh

rm -rf omni *.zip
mkdir -p omni

[ -e /c/Program\ Files/Mozilla\ Firefox/browser/omni.ja ] && OMNI=/c/Program\ Files/Mozilla\ Firefox/browser/omni.ja
[ -e /usr/lib/firefox/browser/omni.ja ] && OMNI=/usr/lib/firefox/browser/omni.ja
cp "$OMNI" ./

unzip -d omni omni.ja
sed -i -e '/<key id="key_privatebrowsing"/{ N; s/accel,shift/accel,alt,shift/}' \
	omni/chrome/browser/content/browser/browser.xhtml

which zip &> /dev/null && ZIP=zip OPT="-r" || ZIP=/c/Program\ Files/7-Zip/7z.exe OPT='a'
cd omni && "$ZIP" $OPT ../omni.ja.zip *
cd ..
rm -f "$OMNI"
cp omni.ja.zip "$OMNI"

# Linux aries
rm  /home/morgan/.cache/mozilla/firefox/47f7vds8.default/startupCache/startupCache.8.little
# Windows 10 VATICS
rm -f /c/Users/morgan.chang/AppData/Local/Mozilla/Firefox/Profiles/6qja40ki.default-beta/startupCache/startupCache.8.little
# Windows 10 orion
rm -f /c/Users/morgan/AppData/Local/Mozilla/Firefox/Profiles/ge0idutt.default-beta/startupCache/startupCache.8.little
