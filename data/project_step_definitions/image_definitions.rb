
require 'docker'
require 'pp'

# given an array of docker container or images,
# this creates comman-delim string of all short ids
def short_ids(images)
	images.map { |img| img.id.to_s }
		.map { |x| x[0..11] }
		.join(',')
end

# Checks if param is non-empty rgd. String, Number and array size
def be_set(o)
	return unless o 
	if o.class == String
		return (o.to_s.size > 0)
	end
	if o.class == Array
		return o.size > 0
	end
	if o.is_a?(Numeric)
		return o > 0
	end
end

# Given a regexp for a Docker RepoTags entry, this
# returns all images that match expression
def select_regexp_matching_images(re_hn)
  Docker::Image.all.select { |img|
    info_map = img.info
    info_map && info_map['RepoTags'] && info_map['RepoTags'].any? { |n| n.match re_hn }
  }
end

#
# 0. targeting and locating images
#

Given /^i pull '([a-zA-Z0-9_]+)'$/ do |repo|
  begin
    Docker::Image.create({ :fromImage => "#{repo}:latest" })
  rescue => e
    fail "Unable to pull repo/tag #{repo}:latest"
  end
end

Given /^i pull '([a-zA-Z0-9_]+):(.*)'$/ do |repo,tag|
  begin
    res = Docker::Image.create({ :fromImage => "#{repo}:#{tag}" })
  rescue => e
    fail "Unable to pull repo/tag #{repo}:#{tag}"
  end
end

When /^there are images$/ do
	@matching_images = Docker::Image.all
  fail "No images found" if @matching_images.size == 0
end

When /^there are images with repo '(.*)'$/ do |repo|
  @matching_images = select_regexp_matching_images(Regexp.new("#{repo}:.*"))
	fail "No images with repo=#{repo} found" if @matching_images.size == 0
end

When /^there are images with tags like '(.*)'$/ do |hn|
	re_hn = Regexp.new hn
  @matching_images = ( @matching_images || Docker::Image.all ).select { |img|
		info_map = img.info
		info_map && info_map['RepoTags'] && info_map['RepoTags'].any? { |n| n.match re_hn }
	}
  fail "No images with tags like #{hn} found" if @matching_images.size == 0
end

When /^there are images tagged '(.*)'$/ do |hn|
	@matching_images = ( @matching_images || Docker::Image.all ).select { |img|
		info_map = img.info
		info_map && info_map['RepoTags'] && info_map['RepoTags'].any? { |n| n == hn }
	}
  fail "No image(s) tagged #{hn} found" if @matching_images.size == 0
end


# 1st level, full match

Then(/^'(.*)' should be '(.*)'$/) do |key,arg|
	err =( @matching_images || Docker::Image.all ).select do |img|
		img.json[key] != arg
	end
	fail "#{err.size} image(s) do not have #{key} of #{arg} but should have: #{short_ids(err)}" if err.size > 0
end

Then(/^'(.*)' should not be '(.*)'$/) do |key,arg|
	err = ( @matching_images || Docker::Image.all ).select do |img|
		img.json[key] == arg
	end
	fail "#{err.size} image(s) do have #{key} of #{arg} but should not have: #{short_ids(err)}" if err.size > 0
end

# 1st level, regexp
#
Then(/^'(.*)' should be like '(.*)'$/) do |key,arg|
	re = Regexp.new arg
	err = ( @matching_images || Docker::Image.all ).select do |img|
		img.json[key] && !( img.json[key].match re )
	end
  fail  "#{err.size} image(s) do not have #{key} like #{arg} but should have: #{short_ids(err)}" if err.size > 0
end

Then(/^'(.*)' should not be like '(.*)'$/) do |key,arg|
	re = Regexp.new arg
	err = ( @matching_images || Docker::Image.all ).select do |img|
		img.json[key] && ( img.json[key].match re )
	end
  fail  "#{err.size} image(s) do have #{key} like #{arg} but should not have: #{short_ids(err)}" if err.size > 0
end

# 1st level, general
Then(/^'(.*)' should be set$/) do |key|
	err = ( @matching_images || Docker::Image.all ).select do |img|
		(img.json[key] == nil) || (
			img.json[key] && !( be_set(img.json[key]))
		)
	end
  fail  "#{err.size} image(s) do not have #{key} set (but should have): #{short_ids(err)}" if err.size > 0
end

Then(/^'(.*)' should not be set$/) do |key|
	err = ( @matching_images || Docker::Image.all ).select do |img|
		img.json[key] && ( be_set(img.json[key]))
	end
  fail  "#{err.size} image(s) do have #{key} set (but should not have): #{short_ids(err)}" if err.size > 0
end


