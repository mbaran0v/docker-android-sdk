[![Build Status](https://travis-ci.org/mbaran0v/docker-android-sdk.svg?branch=master)](https://travis-ci.org/mbaran0v/docker-android-sdk)

# docker-android-sdk

Therea are dockerfile for build Andoroid Applications.

If you want to change SDK,Platform etc. version - change 42,44 rows in Dockerfile

For build images:
* docker build --tag=docker-android-sdk .

For build application:
* cp ~/Projects/AndroidProject/
* docker run -ti --rm -v $(pwd):/usr/src/ bash
* gradle assembleDebug
