FROM openjdk:9-jdk
MAINTAINER Manuel Sabogal <mfer32@gmail.com>

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}:${ANDROID_HOME}/tools
ENV ANDROID_NDK /opt/android-ndk-linux
ENV ANDROID_NDK_HOME ${ANDROID_NDK}
ENV SDKMANAGER_OPTS "--add-modules java.se.ee"

RUN mkdir -p /opt/android-sdk-linux && mkdir -p ~/.android && touch ~/.android/repositories.cfg
WORKDIR /opt

RUN apt-get update && apt-get install -y --no-install-recommends \
	unzip \
	wget
RUN cd ${ANDROID_HOME} && \
	wget -q --output-document=sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && \
	unzip sdk-tools.zip && \
	rm -f sdk-tools.zip && \
	echo y | sdkmanager "build-tools;29.0.0" "platforms;android-26" && \
	echo y | sdkmanager "extras;android;m2repository" "extras;google;m2repository" "extras;google;google_play_services" && \
	sdkmanager "cmake;3.10.2.4988404"
RUN wget -q --output-document=android-ndk.zip https://dl.google.com/android/repository/android-ndk-r20-linux-x86_64.zip && \
	unzip android-ndk.zip && \
	rm -f android-ndk.zip && \
	mv android-ndk-r20 android-ndk-linux
