# Path to PICO-8 binary
PROJECT_NAME = my_game

# PICO8 variables
PICO8 = /usr/bin/pico8
MAIN_CART = main.p8
OPTIONS = -windowed 1 -root_path src -desktop capture

# Butler variables
ITCH_USER = ghettobastler
ITCH_PROJECT = private_test_zone

clean_web:
	rm -rf export/web
	mkdir -p export/web

clean_bin:
	rm -rf export/bin
	mkdir -p export/bin

clean_png:
	rm -rf export/png
	mkdir -p export/png

.ONESHELL:
web: clean_web version_file
	${PICO8} ${OPTIONS} src/${MAIN_CART} -export "-f export/web/${PROJECT_NAME}.html"
	cd export/web
	zip -9 -r ${PROJECT_NAME}.zip ${PROJECT_NAME}_html

bin: clean_bin version_file
	${PICO8} ${OPTIONS} src/${MAIN_CART} -export "-f export/bin/${PROJECT_NAME}.bin"

png: clean_png version_file
	${PICO8} ${OPTIONS} src/${MAIN_CART} -export "-f export/png/${PROJECT_NAME}.p8.png"

run:
	${PICO8} ${OPTIONS} -run src/${MAIN_CART}

push: web
	butler push export/web/${PROJECT_NAME}.zip ${ITCH_USER}/${ITCH_PROJECT}:html --userversion-file VERSION

version_file:
	sed -nE 's/VERSION = "([^"]+)"/\1/p' src/${MAIN_CART} > VERSION


.PHONY: clean_web clean_bin clean_png serve run push
