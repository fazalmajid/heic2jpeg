all: heic2jpeg

heic2jpeg: heic2jpeg.swift
	swiftc -O -o $@ $^

clean:
	-rm -f heic2jpeg *~ core
