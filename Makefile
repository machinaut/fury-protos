.PHONY: all deb py

# Set FURY_USER and FURY_SECRET environment variables
FURY=https://$(FURY_SECRET)@push.fury.io/$(FURY_USER)/
PROTOS=$(shell ls fury_protos/*.proto)
PY=fury_protos
DEB=$(shell pwd)/deb

all: deb py

deb:
	docker build -t fury_protos_builder .
	rm -rf deb/build deb/release/*.deb
	mkdir -p deb/build
	mkdir -p deb/release
	docker run -v $(DEB)/build:/build -v $(DEB)/release:/release fury_protos_builder

py: # Workaround https://github.com/google/protobuf/issues/1491
	rm -rf dist $(PY)/*pb2.py $(PY)/*pb2_grpc.py
	python -m grpc_tools.protoc -I. --python_out=. --grpc_python_out=. $(PROTOS)
	python setup.py sdist

upload: deb py
	debfile=$$(ls $(DEB)/release/*.deb); curl -F package=@$$debfile $(FURY)
	pyfile=$$(ls dist/*.tar.gz); curl -F package=@$$pyfile $(FURY)
