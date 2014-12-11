
`spec-serverspec` is used as a command container to run a serverspec specification from a given volume.
Its resource types `docker_image` and `docker_container` can be used to check for a single image/container
and its attributes.

```bash
$ # for convenience
$ docker tag dewiring/spec_serverspec:0.1 serverspec:latest

$ cd <to some example spec dir>
$ cat test_spec.rb
require 'spec_helper.rb'

describe docker_image('nginx:latest') do
	it { should exist }
	its(:inspection) { should include 'Architecture' => 'amd64' }
end

$ export DS=/var/run/docker.sock
$ docker run --rm -v $DS:$DS -v `pwd`:/spec serverspec
/usr/bin/ruby2.1 -I/var/lib/gems/2.1.0/gems/rspec-support-3.1.2/lib:/var/lib/gems/2.1.0/gems/rspec-core-3.1.7/lib /var/lib/gems/2.1.0/gems/rspec-core-3.1.7/exe/rspec --pattern spec/localhost/\*_spec.rb

Docker image "nginx:latest"
  should exist
  inspection
    should include {"Architecture" => "amd64"}

Finished in 0.33068 seconds (files took 0.54721 seconds to load)
2 examples, 0 failures
```
