#!/bin/bash
set -x # Echo on
# Reset pwd
cd /var/www/html
# Configure path variables
minetestmapper="/root/programming/minetestmapper/minetestmapper"
worldpath="/var/games/minetest-server/.minetest/worlds/world_dragon/"
symbolpath="./maps/latest.png"
# Get current date in required format
printf -v date '%(%Y%m%d)T' -1
filename="${date}.png"
filepath="./maps/${filename}"
# Compile new map
${minetestmapper} -i ${worldpath} -o ${filepath} --scales br --drawalpha --draworigin --drawplayers --drawscale --origincolor '#ffff00'
# Update symbolic link
ln -r -sf ${filepath} ${symbolpath}
# Update webpage
printf -v date2 '%(%Y-%m-%d)T' -1
sed -i -e "s/Update per: [[:digit:]][[:digit:]][[:digit:]][[:digit:]]-[[:digit:]][[:digit:]]-[[:digit:]][[:digit:]]/Update per: ${date2}/g" index.html
# Update git repository
git add .
git commit -a -m "Automatic update per ${date}"
git push

