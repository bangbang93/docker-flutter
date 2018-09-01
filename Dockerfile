FROM centos

RUN yum install -y java wget unzip which libstdc++ \
 && yum groupinstall -y "Development Tools"

ENV ANDROID_HOME /opt/android-sdk-linux

RUN export ANDROID_SDK_TOOLS_VERSION=4333796 \
 && cd /opt \
 && wget -q https://dl.google.com/android/repository/sdk-tools-linux-$ANDROID_SDK_TOOLS_VERSION.zip -O android-sdk-tools.zip \
 && unzip -q android-sdk-tools.zip -d ${ANDROID_HOME} \
 && rm android-sdk-tools.zip \
 && export PATH=${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools \
 && yes | sdkmanager --licenses \
 && sdkmanager tools \
 && sdkmanager platform-tools \
 && sdkmanager emulator

ENV PATH=${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools \
FLUTTER_HOME=${HOME}/sdks/flutter

RUN git clone https://github.com/flutter/flutter.git ${FLUTTER_HOME} \
 && ln -s ${FLUTTER_HOME}/bin/flutter /usr/local/bin/flutter \
 && flutter doctor

ENV PATH=${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin \
    GRADLE_OPTS=-Dorg.gradle.daemon=false 