FROM scratch:latest

MAINTAINER 'images built by devs <maintained by nobody>'

ENV TESTKEY1 TESTENTRY1
ENV TESTKEY2 TESTENTRY2

EXPOSE 80
EXPOSE 443

USER vagrant

CMD [ 'test' ]
ENTRYPOINT [ '/bin/test', '-c' ]

