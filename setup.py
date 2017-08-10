#!/usr/bin/env python

from setuptools import setup, find_packages

setup(name='fury-protos',
      version=open('VERSION').read(),
      description='Example protobuf/grpc prebuilt package',
      author='Alex Ray',
      author_email='a@machinaut.com',
      install_requires=['grpcio', 'grpcio-tools'],
      packages=find_packages())
