# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)
SHELL:=/usr/bin/bash

.PHONY: all

all: clean init

	mkdir --parents $(PWD)/build/tmp
	mkdir --parents $(PWD)/build/Boilerplate.AppDir

	curl -fsS https://dlang.org/install.sh | bash -s dmd

	git clone https://github.com/abraunegg/onedrive.git $(PWD)/build/onedrive

	source ~/dlang/dmd-2.100.0/activate && cd $(PWD)/build/onedrive && ./configure --enable-notifications  --prefix=$(PWD)/build/tmp
	source ~/dlang/dmd-2.100.0/activate && cd $(PWD)/build/onedrive && make clean; make
	source ~/dlang/dmd-2.100.0/activate && cd $(PWD)/build/onedrive && make install

	mkdir --parents $(PWD)/build/Boilerplate.AppDir
	$(PWD)/bin/Apprepo.AppImage --destination=$(PWD)/build appdir boilerplate \
		libnotify4 libcurl4 libsqlite3-0

	echo ''                                      >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo ''                                      >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '$${APPDIR}/bin/onedrive "$${@}"'       >> $(PWD)/build/Boilerplate.AppDir/AppRun

	cp --recursive --force $(PWD)/build/tmp/* $(PWD)/build/Boilerplate.AppDir

	rm --force $(PWD)/build/Boilerplate.AppDir/*.svg      || true
	rm --force $(PWD)/build/Boilerplate.AppDir/*.desktop  || true
	rm --force $(PWD)/build/Boilerplate.AppDir/*.png      || true

	cp --force $(PWD)/AppDir/*.png 		$(PWD)/build/Boilerplate.AppDir/ || true
	cp --force $(PWD)/AppDir/*.desktop 	$(PWD)/build/Boilerplate.AppDir/ || true
	cp --force $(PWD)/AppDir/*.svg 		$(PWD)/build/Boilerplate.AppDir/ || true

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/Boilerplate.AppDir $(PWD)/OneDrive.AppImage
	chmod +x $(PWD)/OneDrive.AppImage

init:
	mkdir --parents $(PWD)/bin

	wget https://apprepo.de/appimage/download/apprepo \
		--output-document=$(PWD)/bin/Apprepo.AppImage
	chmod +x $(PWD)/bin/Apprepo.AppImage

	wget https://github.com/AppImage/AppImageKit/releases/download/13/appimagetool-x86_64.AppImage \
		--output-document=$(PWD)/bin/appimagetool.AppImage
	chmod +x $(PWD)/bin/appimagetool.AppImage

clean:
	rm -rf $(PWD)/*.AppImage
	rm -rf $(PWD)/bin/*
	rm -rf $(PWD)/build
