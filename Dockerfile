FROM centos

# init
RUN yum install -y java java-devel wget unzip which libstdc++ libstdc++.i686 \
 && yum groupinstall -y "Development Tools"

# install android sdk
ENV ANDROID_HOME /opt/android-sdk-linux
ENV ANDROID_SDK_TOOLS_VERSION 4333796

RUN cd /opt \
 && wget -q https://dl.google.com/android/repository/sdk-tools-linux-$ANDROID_SDK_TOOLS_VERSION.zip -O android-sdk-tools.zip \
 && unzip -q android-sdk-tools.zip -d ${ANDROID_HOME} \
 && rm android-sdk-tools.zip \
 && export PATH=${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools \
 && yes | sdkmanager --licenses \
 && sdkmanager tools \
 && sdkmanager platform-tools \
 && sdkmanager emulator

ENV PATH=${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

# android sdk 27
ENV ANDROID_PLATFORM_VERSION 27
ENV ANDROID_BUILD_TOOLS_VERSION 27.0.3

RUN yes | sdkmanager \
    "platforms;android-$ANDROID_PLATFORM_VERSION" \
    "build-tools;$ANDROID_BUILD_TOOLS_VERSION"

# install flutter
ENV FLUTTER_HOME=/opt/flutter

RUN git clone https://github.com/flutter/flutter.git ${FLUTTER_HOME} \
 && ln -s ${FLUTTER_HOME}/bin/flutter /usr/local/bin/flutter \
 && flutter doctor

ENV PATH=${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin \
    GRADLE_OPTS=-Dorg.gradle.daemon=false \
    LANG=en_US.UTF8