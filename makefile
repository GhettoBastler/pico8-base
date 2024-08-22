# Path to PICO-8 binary
PICO8 = /usr/bin/pico8
# Name of the cart
NAME = cartname
# Interface to use for the webserver
IFACE = wlan0

CART = main.p8
OPTIONS = -root_path src
IP = $(shell ip addr show $(IFACE) | grep 'inet ' | sed 's/\s\+inet \([^/ ]\+\).*/\1/g')

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
web: clean_web
	${PICO8} ${OPTIONS} src/${CART} -export "-f export/web/${NAME}.html"
	cd export/web
	zip -9 -r ${NAME}.zip ${NAME}_html

bin: clean_bin
	${PICO8} ${OPTIONS} src/${CART} -export "-f export/bin/${NAME}.bin"

png: clean_png
	${PICO8} ${OPTIONS} src/${CART} -export "-f export/png/${NAME}.p8.png"

run:
	${PICO8} ${OPTIONS} -run src/${CART}

.ONESHELL:
serve: web
	cd export/web/${NAME}_html
	segno http://$(IP):8000 && python -m http.server

.PHONY: clean_web clean_bin clean_png serve run
