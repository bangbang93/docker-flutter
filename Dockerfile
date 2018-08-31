FROM cirrusci/flutter

RUN flutter channel master \
 && flutter upgrade