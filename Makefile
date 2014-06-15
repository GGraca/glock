# glock - glock locker
# See LICENSE file for copyright and license details.

include config.mk

SRC = glock.c
OBJ = ${SRC:.c=.o}

all: options glock

options:
	@echo glock build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.mk

glock: ${OBJ}
	@echo CC -o $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f glock ${OBJ} glock-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p glock-${VERSION}
	@cp -R LICENSE Makefile README config.mk ${SRC} glock-${VERSION}
	@tar -cf glock-${VERSION}.tar glock-${VERSION}
	@gzip glock-${VERSION}.tar
	@rm -rf glock-${VERSION}

install: all
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f glock ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/glock
	@chmod u+s ${DESTDIR}${PREFIX}/bin/glock

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/glock

.PHONY: all options clean dist install uninstall
