if [ $(uname -s) = 'Darwin' ]
then
  sed "s/Meta/Mod/g" hotkeys.template.json > hotkeys.json
else
  sed "s/Ctrl/Mod/g" hotkeys.template.json > hotkeys.json
fi
