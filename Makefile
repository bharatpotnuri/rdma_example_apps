APPS = rping #\
	cmatose \
	cmtime \
	common \
	mckey  \
	rcopy  \
	rdma_client \
	rdma_server \
	rdma_xclient \
	rdma_xserver \
	riostream \
	rstream \
	udaddy \
	udpong

ifeq ($(PREFIX),)
    PREFIX := /usr/local
endif

EXTRA_HEADERS = 

all: ${APPS} 

CFLAGS += -Wall -g -I/usr/include/ 

#The following seems to help GNU make on some platforms
LOADLIBES += 
LDFLAGS += 

${APPS}: LOADLIBES += -libverbs -lrdmacm -lpthread -lrt

${APPS} ${UTILS}: %: %.c ${EXTRA_FILES} ${EXTRA_HEADERS} 
	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $< ${EXTRA_FILES} $(LOADLIBES) -o $@ -L.
clean:
	rm -f ${APPS} ${UTILS} *.o
install:
	install -m 755 rping $(PREFIX)/bin
uninstall:
	rm -f $(PREFIX)/bin/rping

.DELETE_ON_ERROR:
.PHONY: all clean
