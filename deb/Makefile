.PHONY: all install

all: libfuryprotos.a

DST=/usr/local
PROTOS=$(shell ls fury_protos/*.proto)
HDR=$(subst .proto,.pb.h,$(PROTOS)) $(subst .proto,.grpc.pb.h,$(PROTOS))
OBJ=$(subst .proto,.pb.o,$(PROTOS)) $(subst .proto,.grpc.pb.o,$(PROTOS))

AR=ar
CC=g++
CFLAGS=-std=c++11 -fPIC -I/usr/local/include -I.
LDFLAGS=-L/usr/local/lib -lprotobuf -lgrpc++

%.pb.cc %.grpc.pb.cc %.pb.h %.grpc.pb.h: %.proto
	protoc --plugin=protoc-gen-grpc=/usr/local/bin/grpc_cpp_plugin -I=. --cpp_out=. --grpc_out=. $<

%.o: %.cc $(HDR)
	$(CC) $(CFLAGS) -o $@ -c $< $(LDFLAGS)

libfuryprotos.a: $(OBJ) $(HDR)
	$(AR) rcs $@ $^

install: libfuryprotos.a $(HDR)
	install -d $(DST)/lib
	install libfuryprotos.a $(DST)/lib/libfuryprotos.a
	install -d $(DST)/include/fury_protos
	$(foreach h, $(HDR), install $(h) $(DST)/include/$(h) && ) exit 0 || exit 1
