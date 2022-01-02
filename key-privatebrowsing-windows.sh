#!/bin/sh

rm -rf omni *.zip
rm -rf *.zip
mkdir -p omni
cp /c/Program\ Files/Mozilla\ Firefox/browser/omni.ja ./
unzip -d omni omni.ja
sed -i -e '/<key id="key_privatebrowsing"/{ N; s/accel,shift/accel,alt,shift/}' \
	omni/chrome/browser/content/browser/browser.xhtml
cd omni && /c/Program\ Files/7-Zip/7z.exe a ../omni.ja.zip *
rm -f /c/Program\ Files/Mozilla\ Firefox/browser/omni.ja
cp omni.ja.zip /c/Program\ Files/Mozilla\ Firefox/browser/omni.ja


rm -f /c/Users/morgan.chang/AppData/Local/Mozilla/Firefox/Profiles/810fjj3t.default/startupCache/startupCache.8.little
rm -f /c/Users/morgan/AppData/Local/Mozilla/Firefox/Profiles/ge0idutt.default-beta/startupCache/startupCache.8.little
