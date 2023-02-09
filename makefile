REPO = esismal-mobile
IMAGE_TAG ?= main

DIND_PREFIX ?= $(HOME)
ifneq ($(HOST_PATH),)
DIND_PREFIX := $(HOST_PATH)
endif

PREFIX=$(shell echo $(PWD) | sed -e s:$(HOME):$(DIND_PREFIX):)

gen-keystore:
	echo "Generate keystore manually with code below and this gonna replace current keystore in ./android/app/key.jks"
	echo "Uncomment the command if needed"
	#keytool -genkey -v -keystore ./android/app/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key

release-apk:
	chmod +x ./build.sh
	./build.sh

gen-sha-key:
	keytool -list -v -keystore ./android/app/key.jks -alias key -storepass JumpaDokter2021% -keypass JumpaDokter2021%