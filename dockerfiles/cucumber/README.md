
`cucumber` takes specbase and adds step definitions and an entrypoints that runs cucumber. For this
to work, a container needs a volume with cucumber features mounted to /spec, and the docker socket:

```bash
$ export DS=/var/run/docker.sock

$ cd <to your feature dir>
$ docker run -v `pwd`:/spec/features -v $DS:$DS cucumber --color

- or -

$ cd <to your base dir where features/ is in>
$ docker run -v `pwd`:/spec -v $DS:$DS cucumber --color

```

