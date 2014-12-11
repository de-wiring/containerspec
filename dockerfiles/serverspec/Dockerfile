FROM de_wiring/spec_base

RUN	apt-get update -yqq && apt-get install -yqq docker.io && rm -rf /var/lib/apt/lists/*

ADD ./spec /serverspec/spec
ADD Rakefile /serverspec/Rakefile
ADD .rspec /serverspec/.rspec
ADD entrypoint.sh /entrypoint.sh

WORKDIR /serverspec

ENTRYPOINT [ "/entrypoint.sh" ]
