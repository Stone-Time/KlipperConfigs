#!/bin/bash

echo
echo ---------------------------------------------------
echo -e "--------------------- \033[31mK\033[0mlipper ---------------------"
echo ------- Dieses Script kompiliert und flasht -------
echo ------ die MCU vom SKR E3 Turbo Turbo und der RPi. -----
echo ---------------------------------------------------
echo
echo ---------------------------------------------------
echo ----------------- Bitte drücken Sie ---------------
echo -e "------------- [\033[34mEnter\033[0m] zum Fortfahren. -------------"
echo ---------------------------------------------------
echo -e "------------- Zum Abbrechen [\033[31mSTRG - C\033[0m] ------------"
read -p $'---------------------------------------------------\n'

#Verzeichnisswechsel
cd ~/klipper/


#Klipper Stoppen
echo
echo ---------------------------------------------------
echo -e "-------------- \033[31mK\033[0mlipper wird gestoppt --------------"
echo -------- bitte das ROOT Passwort eingeben. --------
echo ---------------------------------------------------
sudo service klipper stop

#SKR E3
echo
echo ---------------------------------------------------
echo ------------- Das SKR E3 Turbo Board -------------
echo ----------------- wird kompiliert -----------------
echo ---------------------------------------------------
#make menuconfig
cp ~/klipper_build/skr.config ~/klipper/.config
make clean
make
echo
echo ---------------------------------------------------
echo ------------- Das SKR E3 Turbo Board -------------
echo ------------------ wird geflasht ------------------
echo ---------------------------------------------------
./scripts/flash-sdcard.sh /dev/ttyACM0 btt-skr-e3-turbo

#RPi
echo
echo ---------------------------------------------------
echo ------------- Die RPi wird kompiliert -------------
echo ---------------------------------------------------
#make menuconfig
cp ~/klipper_build/pi.config ~/klipper/.config
make clean
echo
echo ---------------------------------------------------
echo -------------- Die RPi wird geflasht --------------
echo ---------------------------------------------------
make flash

#klipper starten
echo
echo ---------------------------------------------------
echo -e "--------- \033[31mK\033[0mlipper wird wieder gestarted -----------"
echo ---------------------------------------------------
sudo service klipper start


echo
echo ---------------------------------------------------
echo --------- Alle MCUs sind wieder aktuell -----------
echo ---------------------------------------------------

