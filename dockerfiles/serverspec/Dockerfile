FROM dewiring/spec_base

MAINTAINER Andreas Schmidt <andreas@de-wiring.net>

RUN	apt-get update -yqq && apt-get install -yqq docker.io && rm -rf /var/lib/apt/lists/*

ADD ./spec /serverspec/spec
RUN mkdir /serverspec/spec/localhost
ADD Rakefile /serverspec/Rakefile
ADD .rspec /serverspec/.rspec
ADD entrypoint.sh /entrypoint.sh

WORKDIR /serverspec

ENTRYPOINT [ "/entrypoint.sh" ]
