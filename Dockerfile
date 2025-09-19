FROM alpine:latest

RUN cd /root && \
   wget --no-check-certificate "https://cache-redirector.jetbrains.com/intellij-jbr/jbr_jcef-21.0.8-linux-x64-b1115.48.tar.gz"

WORKDIR /root

CMD ["sh"]