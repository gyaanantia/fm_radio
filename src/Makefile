SHELL = /bin/sh

OBJS = main.o fm_radio.o audio.o
CC = g++

all:
	touch audio_dump.bin
	touch audio_output.txt
	touch audio_trimmed.txt
	g++ fm_radio.cpp audio.cpp main.cpp -o fm_radio
	./fm_radio test/usrp.dat
	hexdump -C audio_dump.bin > audio_output.txt
	python3 clean.py

