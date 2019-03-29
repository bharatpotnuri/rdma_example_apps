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
.DELETE_ON_ERROR:
.PHONY: all clean
