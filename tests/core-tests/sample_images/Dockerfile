FROM scratch:latest

MAINTAINER test.maintainer@de-wiring.net

ENV TESTKEY1 TESTENTRY1
ENV TESTKEY2 TESTENTRY2

EXPOSE 80
EXPOSE 443

USER vagrant

CMD [ "test" ]
ENTRYPOINT [ "/bin/test", "-c" ]

