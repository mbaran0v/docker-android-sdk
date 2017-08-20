FROM openjdk:8-jdk

MAINTAINER maksim.baranov@gmail.com

ENV LANG en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

ENV ANDROID_HOME /home/user/android-sdk-linux
ENV ANDROID_CLI_TOOLS_VERSION 25.2.5
ENV GRADLE_VERSION 3.3

RUN apt-get update && \
      apt-get install --no-install-recommends --no-install-suggests -y \
        git \
        curl \
        zip \
        lib32stdc++6 \
        lib32z1 && \
      rm -rf /var/lib/apt/lists/*

RUN useradd -m user
USER user
WORKDIR /home/user

RUN curl -fSL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip -o gradle-${GRADLE_VERSION}.zip && \
    unzip gradle-${GRADLE_VERSION}.zip && \
    rm -f gradle-${GRADLE_VERSION}.zip && \
    mv gradle-${GRADLE_VERSION} gradle && \
    mkdir -p .gradle && \
    \
    mkdir -p $ANDROID_HOME .android && \
    cd $ANDROID_HOME && \
    curl -fSL https://dl.google.com/android/repository/tools_r${ANDROID_CLI_TOOLS_VERSION}-linux.zip -o sdk_${ANDROID_CLI_TOOLS_VERSION}.zip && \
    unzip sdk_${ANDROID_CLI_TOOLS_VERSION}.zip && \
    rm -f sdk_${ANDROID_CLI_TOOLS_VERSION}.zip && \
    mkdir -p ${ANDROID_HOME}/licenses/ && \
    echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > ${ANDROID_HOME}/licenses/android-sdk-license

ENV PATH "/home/user/gradle/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${PATH}"

 # build.gradle compileSdkVersion
ENV ANDROID_COMPILE_SDK_VERSION 26
 # build.gradle buildToolsVersion
ENV ANDROID_BUILD_TOOLS_VERSION 26.0.1

RUN for item in "android-${ANDROID_COMPILE_SDK_VERSION}" "build-tools-${ANDROID_BUILD_TOOLS_VERSION}" "platform-tools" "extra-android-m2repository"; do \
      echo y | android --silent update sdk --no-ui --all --filter $item; \
    done;
