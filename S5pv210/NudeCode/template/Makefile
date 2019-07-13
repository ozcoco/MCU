## target
BUILD   := xxx
TARGET := ${BUILD}.bin

## objects
COBJS += start.o
COBJS += main.o

##SD or RAM
ENV	     ?= SD
SD_TOOLS := mk210

CROSS_COMPILE = arm-linux-gnueabihf-

CC      := ${CROSS_COMPILE}gcc
LD      := ${CROSS_COMPILE}ld
AR      := ${CROSS_COMPILE}ar
OBJCOPY := ${CROSS_COMPILE}objcopy
OBJDUMP := ${CROSS_COMPILE}objdump

#INCLUDEDIR 	+= ${shell pwd}/include
INC_DIR 	+= ./include
CFLAGS 		+= -Wall
CFLAGS   	+= -I${INC_DIR}

LDFLAGS		+= -Tlink.lds
ifeq (${ENV},RAM)
LDFLAGS		+= -Ttext=0x20000000
else
LDFLAGS		+= -Ttext=0x0
endif

## compile files
all: ${TARGET}
ifeq (${ENV},RAM)
${TARGET}:${BUILD}
	${OBJCOPY}	-O binary -S $^ $@
else
${TARGET}: ${BUILD}
	${OBJCOPY}	-O binary -S $^ $@.TMP
	gcc mkv210_image.c -o ${SD_TOOLS}
	./${SD_TOOLS} $@.TMP $@
	${OBJDUMP} -D ${BUILD} > ${BUILD}.dis
endif

${BUILD}:${COBJS}
	${LD}  ${LDFLAGS} -o $@ $^
	
%.o:%.c
	${CC}  $(CFLAGS) -c -o $@ $^

%.o:%.S
	${CC}  $(CFLAGS) -c -o $@ $^

install:
	cp ${TARGET} ../bin

uninstall:
	rm -f ../bin/${TARGET}

clean:
	rm -f ${BUILD} ${TARGET} *.o ${SD_TOOLS} *.TMP *.dis

.PHONY: all clean install uninstall