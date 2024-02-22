#!/bin/bash

cd 
mkdir pico 
cd pico

git clone https://github.com/raspberrypi/pico-sdk.git --branch master
cd pico-sdk
git submodule update --init
cd ..
git clone https://github.com/raspberrypi/pico-examples.git --branch master

cd pico-sdk
git pull
git submodule update
cd pico-examples
mkdir build
cd build

export PICO_SDK_PATH=../../pico-sdk

cmake ..

cd blink

make -j4

read -p "Do you want to run the blink script? (y/n): " choice

if [ "$choice" == "y" ]; then
	echo "Make sure you have connected your Raspberry Pi Pico."
	for i in {1..5}
	do
		echo -n "$i.."
		sleep 1
	done
	sudo fdisk -l | grep RP2 || echo "Pico disconnected"

	sudo mkdir -p /mnt/pico
	sudo mount /dev/sda1 /mnt/pico

	ls /mnt/pico/ 
	sudo cp blink.uf2 /mnt/pico

	sudo sync

else
    echo "Exiting."
fi
