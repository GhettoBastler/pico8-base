# Path to PICO-8 binary
PICO8 = /usr/bin/pico8
# Name of the cart
NAME = cartname

CART = main.p8
OPTIONS = -windowed 1 -root_path src -desktop capture
ITCH_USER = ghettobastler

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
	${PICO8} ${OPTIONS} src/${CART} -export "-f export/web/${NAME}.html"
	cd export/web
	zip -9 -r ${NAME}.zip ${NAME}_html

bin: clean_bin version_file
	${PICO8} ${OPTIONS} src/${CART} -export "-f export/bin/${NAME}.bin"

png: clean_png version_file
	${PICO8} ${OPTIONS} src/${CART} -export "-f export/png/${NAME}.p8.png"

run:
	${PICO8} ${OPTIONS} -run src/${CART}

push: web
	butler push export/web/${NAME}.zip ${ITCH_USER}/${NAME}:html --userversion-file VERSION

version_file:
	sed -nE 's/VERSION = "([^"]+)"/\1/p' src/${CART} > VERSION


.PHONY: clean_web clean_bin clean_png serve run push
