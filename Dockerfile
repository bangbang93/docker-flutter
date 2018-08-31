FROM cirrusci/flutter:base

RUN export FLUTTER_HOME=${HOME}/sdks/flutter \
 && git clone https://github.com/flutter/flutter.git ${FLUTTER_HOME} \
 && sudo ln -s ${FLUTTER_HOME}/bin/flutter /usr/local/bin/flutter \
 && flutter doctor

ENV PATH ${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin
