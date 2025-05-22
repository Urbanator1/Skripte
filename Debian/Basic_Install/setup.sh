#!/bin/bash

#hostname=$(hostname)

echo "Versuche Dateien herunterzuladen ...";

mkdir ./setup;

wget -nv -N -P ./setup https://raw.githubusercontent.com/Urbanator1/Skripte/main/Debian/Basic_Install/bashrc-root;
wget -nv -N -P ./setup https://raw.githubusercontent.com/Urbanator1/Skripte/main/Debian/Basic_Install/bashrc-default;
wget -nv -N -P ./setup https://raw.githubusercontent.com/Urbanator1/Skripte/main/Debian/Basic_Install/motd;
/Basic_Install
if [[ -f "./setup/bashrc-root" ]] && [[ -f "./setup/bashrc-default" ]] && [[ -f "./setup/motd" ]]; then
	echo -e "\n--------------------------------------------------------------------------\n";
	echo "Dateien erfolgreich heruntergeladen!";
else
	exit;
fi;


echo "Bitte gib den gewünschten Hostnamen zur Darstellung in der motd Datei an:";

read hostname;


echo "Dein Hostname der Maschiene lautet: ${hostname}";
echo -e "\n--------------------------------------------------------------------------\n";

echo "Versuche Datein zu kopieren:";

cp -v ./setup/bashrc-default /etc/skel/.bashrc;
cp -v ./setup/bashrc-root /root/.bashrc;

#holen der bereits erstellten Homes...
homes=$(ls -d /home/*);

echo "Kopiere für bereits erstellte User:"
for home in $homes;
do
	cp -v ./setup/bashrc-default $home/.bashrc;
done;

echo -e "\nErstelle motd für -$hostname-:\n";
motd=$(sed -e "s/\(#SERVER: \)/\1$hostname/" ./setup/motd);

echo "$motd";
echo "$motd" > /etc/motd;

echo -e "\n--------------------------------------------------------------------------\n";

while true; do

read -p "Updaten und Tools installieren? (y/n) " yn

case $yn in
	[yY] ) echo Updating ...;
	  timedatectl set-timezone Europe/Vienna
		apt-get update && apt-get upgrade -y;
		apt-get install screen curl wget zip unzip htop nload netstat-nat git sudo -y;
		locale-gen de_DE.UTF-8;
    export LANG=de_DE.UTF-8;

		break;;
	[nN] ) echo Abbrechen ...;
		break;;
	* ) echo Falsche Eingabe;;
esac

done;


echo -e "\n--------------------------------------------------------------------------\n";

while true; do

read -p "Setup Dateien Löschen? (y/n) " yn

case $yn in
	[yY] ) echo Lösche dateien ...;
		rm -r ./setup;
		break;;
	[nN] ) echo Dateien bleiben erhalten ...;
		break;;
	* ) echo Falsche Eingabe;;
esac

done;
#echo "Lade Konsole neu...";
#source ~/.bashrc
echo "Fertig!";





























