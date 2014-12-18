require 'docker'
require 'pp'

# given an array of docker container or images,
# this creates comman-delim string of all short ids
def short_ids(images)
  images.map { |img| img.id.to_s }
  .map { |x| x[0..11] }
  .join(',')
end

# return running containers (running_flag =~ "running ") or all containers
def get_containers(running_flag = nil)
  if running_flag && running_flag =~ /^running/
    return Docker::Container.all
  else
    return Docker::Container.all(:all => true)
  end
end

# for internal test case only
Given(/i rerun container named '(.*)' with '(.*)'/) do |name, args|
  `docker kill #{name} >/dev/null 2>&1`
  `docker rm #{name} >/dev/null 2>&1`
  `docker run --name #{name} #{args}`
end


When(/^there is a ([running ]*)container named '(.*)'$/) do |running_flag, arg|
  @matching_containers = get_containers(running_flag) || []
  @matching_containers = @matching_containers.select { |c|
    c.json['Name'].to_s == "/#{arg.to_s}"
  }
  fail "No #{running_flag}containers named #{arg} found" if @matching_containers.size == 0
end

When(/^there are ([running ]*)containers named like '(.*)'$/) do |running_flag, arg|
  @matching_containers = get_containers(running_flag) || []
  rg = Regexp.new(arg)
  @matching_containers = @matching_containers.select { |c|
    c.json['Name'].to_s.match rg
  }
  fail "No #{running_flag}containers with names like #{arg} found" if @matching_containers.size == 0
end


# 1st level, regexp

Then(/^container '(.*)' should be like '(.*)'$/) do |key, arg|
  re  = Regexp.new arg
  err = (@matching_containers || get_containers).select do |c|
    cc       = c.json
    matching = (cc[key].to_s.match(re) != nil)
    (cc != nil) && (cc[key] != nil) && (matching == false)
  end
  fail "#{err.size} containers(s) do not have #{key} like #{arg} but should have: #{short_ids(err)}" if err.size > 0
end

Then(/^container '(.*)' should not be like '(.*)'$/) do |key, arg|
  re  = Regexp.new arg
  err = (@matching_containers || get_containers).select do |c|
    cc       = c.json
    matching = (cc[key].to_s.match(re) != nil)
    (cc != nil) && (cc[key] != nil) && (matching == true)
  end
  fail "#{err.size} container(s) do have #{key} like #{arg} but should not have: #{short_ids(err)}" if err.size > 0
end

# 2nd level, match

Then(/^within container ([^ ]*), '(.*)' should be '(.*)'$/) do |part, key, arg|
  fail "using within, valid parts are Config,HostConfig,NetworkSettings,State" unless %W( Config HostConfig NetworkSettings State).include? part
  err = (@matching_containers || get_containers).select do |c|
    cc       = c.json[part]
    matching = (cc[key].to_s == arg.to_s)
    (cc != nil) && (cc[key] != nil) && (matching == false)
  end
  fail "#{err.size} containers(s) do not have #{part}.#{key} eq #{arg} but should have: #{short_ids(err)}" if err.size > 0
end

Then(/^within container ([^ ]*), '(.*)' should not be '(.*)'$/) do |part, key, arg|
  fail "using within, valid parts are Config,HostConfig,NetworkSettings,State" unless %W( Config HostConfig NetworkSettings State).include? part
  err = (@matching_containers || get_containers).select do |c|
    cc       = c.json[part]
    matching = (cc[key].to_s == arg.to_s)
    (cc != nil) && (cc[key] != nil) && (matching == true)
  end
  fail "#{err.size} container(s) do have #{part}.#{key} eq #{arg} but should not have: #{short_ids(err)}" if err.size > 0
end

# 2nd level, regexp

Then(/^within container ([^ ]*), '(.*)' should be like '(.*)'$/) do |part, key, arg|
  fail "using within, valid parts are Config,HostConfig,NetworkSettings,State" unless %W( Config HostConfig NetworkSettings State).include? part
  re  = Regexp.new arg
  err = (@matching_containers || get_containers).select do |c|
    cc       = c.json[part]
    matching = (cc[key].to_s.match(re) != nil)
    (cc != nil) && (cc[key] != nil) && (matching == false)
  end
  fail "#{err.size} containers(s) do not have #{part}.#{key} like #{arg} but should have: #{short_ids(err)}" if err.size > 0
end

Then(/^within container ([^ ]*), '(.*)' should not be like '(.*)'$/) do |part, key, arg|
  fail "using within, valid parts are Config,HostConfig,NetworkSettings,State" unless %W( Config HostConfig NetworkSettings State).include? part
  re  = Regexp.new arg
  err = (@matching_containers || get_containers).select do |c|
    cc       = c.json[part]
    matching = (cc[key].to_s.match(re) != nil)
    (cc != nil) && (cc[key] != nil) && (matching == true)
  end
  fail "#{err.size} container(s) do have #{part}.#{key} like #{arg} but should not have: #{short_ids(err)}" if err.size > 0
end

# special purpose

Then(/^(it|they) should not run privileged$/) do |alt|
  part = 'HostConfig'
  key = 'Privileged'
  arg = 'true'  # find those that have priviledge=true
  err = (@matching_containers || get_containers).select do |c|
    cc       = c.json[part]
    matching = (cc[key].to_s == arg.to_s)
    (cc != nil) && (cc[key] != nil) && (matching == true)
  end
  fail "#{err.size} container(s) do have #{part}.#{key} eq #{arg} but should not have: #{short_ids(err)}" if err.size > 0
end

Then(/^(it|they) should run privileged$/) do |alt|
  part = 'HostConfig'
  key = 'Privileged'
  arg = 'false'
  err = (@matching_containers || get_containers).select do |c|
    cc       = c.json[part]
    matching = (cc[key].to_s == arg.to_s)
    (cc != nil) && (cc[key] != nil) && (matching == true)
  end
  fail "#{err.size} container(s) do have #{part}.#{key} eq #{arg} but should not have: #{short_ids(err)}" if err.size > 0
end

Then(/^its environment should include '(.*)'$/) do |arg|
  part = 'Config'
  key = 'Env'

  re  = Regexp.new arg
  err = (@matching_containers || get_containers).select do |c|
    cc       = c.json[part]
    matching = (cc[key].to_s.match(re) != nil)
    (cc != nil) && (cc[key] != nil) && (matching == false)
  end
  fail "#{err.size} containers do not have environment like #{arg} but should have: #{short_ids(err)}" if err.size > 0
end

Then(/^its environment should not include '(.*)'$/) do |arg|
  part = 'Config'
  key = 'Env'

  re  = Regexp.new arg
  err = (@matching_containers || get_containers).select do |c|
    cc       = c.json[part]
    matching = (cc[key].to_s.match(re) != nil)
    (cc != nil) && (cc[key] != nil) && (matching == true)
  end
  fail "#{err.size} containers do have environment like #{arg} but should NOT have: #{short_ids(err)}" if err.size > 0
end

Then(/^container volume '(.*)' should be mounted$/) do |arg|
  re  = Regexp.new arg
  err = (@matching_containers || get_containers).select do |c|
    cc       = c.json['Volumes']
    (cc != nil) && !(cc[arg] != nil && cc[arg].size > 0)
  end
  fail "#{err.size} containers do not have #{arg} as a volume mount, but should have: #{short_ids(err)}" if err.size > 0
end

Then(/^container volume '(.*)' should be mounted read-only$/) do |arg|
  re  = Regexp.new arg
  err = (@matching_containers || get_containers).select do |c|
    cc       = c.json['VolumesRW']
    (cc != nil) && !(cc[arg] != nil && cc[arg].to_s == 'false')
  end
  fail "#{err.size} containers do not have #{arg} as a volume mount, but should have: #{short_ids(err)}" if err.size > 0
end

Then(/^container volume '(.*)' should not be mounted$/) do |arg|
  re  = Regexp.new arg
  err = (@matching_containers || get_containers).select do |c|
    cc       = c.json['Volumes']
    (cc != nil) && (cc[arg] != nil && cc[arg].size > 0)
  end
  fail "#{err.size} containers do not have #{arg} as a volume mount, but should have: #{short_ids(err)}" if err.size > 0
end

Then(/^container volume '(.*)' should be mounted to host volume '(.*)'$/) do |arg, arg_host|
  re  = Regexp.new arg
  err = (@matching_containers || get_containers).select do |c|
    cc       = c.json['Volumes']
    (cc != nil) && !(cc[arg] != nil && cc[arg].to_s == arg_host)
  end
  fail "#{err.size} containers do not have #{arg} as a volume mount, but should have: #{short_ids(err)}" if err.size > 0
end

Then(/^container[s]* should expose port '([^ ]*)'$/) do |arg|
  arg = "#{arg}/tcp" unless (arg =~ /.*\/tcp/) || (arg =~ /.*\/udp/)
  err = (@matching_containers || get_containers).select do |c|
    cc       = ( (c.json['NetworkSettings'] || {})['Ports'] || {} )
    matching = cc[arg] != nil
    ( matching == false )
  end
  fail "#{err.size} containers do not expose port #{arg}, but should: #{short_ids(err)}" if err.size > 0
end

Then(/^container[s]* should expose port '([^ ]*)' on host port '(.*)'$/) do |arg, arg2|
  arg = "#{arg}/tcp" unless (arg =~ /.*\/tcp/) || (arg =~ /.*\/udp/)
  err = (@matching_containers || get_containers).select do |c|
    cc       = ( (c.json['NetworkSettings'] || {})['Ports'] || {} )
    matching = false
    cc[arg].each do |e|
      matching = true if ( e != nil &&
         e['HostPort'] != nil &&
         e['HostPort'].to_s == arg2.to_s )
    end

    ( matching == false )
  end
  fail "#{err.size} containers do not expose port #{arg} on host port #{arg2}, but should: #{short_ids(err)}" if err.size > 0

end

Then(/^container[s]* should not expose port '(.*)'$/) do |arg|
  arg = "#{arg}/tcp" unless (arg =~ /.*\/tcp/) || (arg =~ /.*\/udp/)
  err = (@matching_containers || get_containers).select do |c|
    cc       = ( (c.json['NetworkSettings'] || {})['Ports'] || {} )
    matching = cc[arg] != nil
    ( matching == true )
  end
  fail "#{err.size} containers do expose port #{arg}, but should not: #{short_ids(err)}" if err.size > 0
end

Then(/^(it|they) should run on image '(.*)'$/) do |alt,arg|
  err = (@matching_containers || get_containers).select do |c|
    cc       = c.json['Config'] || {}
    ( cc['Image'].to_s != arg.to_s )
  end
  fail "#{err.size} containers do not run on image #{arg}, but should: #{short_ids(err)}" if err.size > 0
end

Then(/^(it|they) should not run as root$/) do |alt|
  err = (@matching_containers || get_containers).select do |c|
    cc       = c.json['Config'] || {}
    ( cc['User'].to_s == 'root' || cc['User'].to_s == '')
  end
  fail "#{err.size} containers do run as user root, but should not: #{short_ids(err)}" if err.size > 0
end

Then(/^(it|they) should run as user '(.*)'$/) do |alt,arg|
  err = (@matching_containers || get_containers).select do |c|
    cc       = c.json['Config'] || {}
    ( cc['User'].to_s != arg.to_s )
  end
  fail "#{err.size} containers do not run as user #{arg}, but should: #{short_ids(err)}" if err.size > 0
end

Then(/^(it|they) should not run as user '(.*)'$/) do |alt,arg|
  err = (@matching_containers || get_containers).select do |c|
    cc       = c.json['Config'] || {}
    ( cc['User'].to_s == arg.to_s )
  end
  fail "#{err.size} containers do run as user #{arg}, but should not: #{short_ids(err)}" if err.size > 0
end

Then(/^(it|they) should have volumes from '(.*)'$/) do |alt,arg|
  re = Regexp.new(arg)
  err = (@matching_containers || get_containers).select do |c|
    cc       = c.json['HostConfig'] || {}
    !( cc['VolumesFrom'].to_s.match(re) )
  end
  fail "#{err.size} containers do not have volumes from #{arg}, but should: #{short_ids(err)}" if err.size > 0
end

Then(/^(it|they) should not have volumes from '(.*)'$/) do |alt,arg|
  re = Regexp.new(arg)
  err = (@matching_containers || get_containers).select do |c|
    cc       = c.json['HostConfig'] || {}
    ( cc['VolumesFrom'].to_s.match(re) )
  end
  fail "#{err.size} containers do have volumes from #{arg}, but should not: #{short_ids(err)}" if err.size > 0
end

Then(/^(it|they) should be linked to '([^ ]+)' with name '(.*)'$/) do |alt,arg1, arg2|
  re = Regexp.new("^/#{arg1}:.*/#{arg2}$")
  err = (@matching_containers || get_containers).select do |c|
    cc       = ( (c.json['HostConfig'] || {})['Links'] || {} )
    matching = false
    cc.each do |e|
      matching = true if e.to_s.match(re)
    end

    ( matching == false )
  end
  fail "#{err.size} containers do not link to container #{arg1} by name #{arg2}, but should: #{short_ids(err)}" if err.size > 0

end

Then(/^(it|they) should be linked to '([^ ]+)'$/) do |alt,arg1|
  re = Regexp.new("^/#{arg1}:.*")
  err = (@matching_containers || get_containers).select do |c|
    cc       = ( (c.json['HostConfig'] || {})['Links'] || {} )
    matching = false
    cc.each do |e|
      matching = true if e.to_s.match(re)
    end

    ( matching == false )
  end
  fail "#{err.size} containers do not link to container #{arg1}, but should: #{short_ids(err)}" if err.size > 0

end

Then(/^(it|they) should not be linked to '([^ ]+)'$/) do |alt,arg1|
  re = Regexp.new("^/#{arg1}:.*")
  err = (@matching_containers || get_containers).select do |c|
    cc       = ( (c.json['HostConfig'] || {})['Links'] || {} )
    matching = false
    cc.each do |e|
      matching = true if e.to_s.match(re)
    end

    ( matching == true )
  end
  fail "#{err.size} containers do link to container #{arg1}, but should not: #{short_ids(err)}" if err.size > 0

end
