require 'spec_helper.rb'

describe docker_image('nginx:latest') do
	it { should exist }
	its(:inspection) { should include 'Architecture' => 'amd64' }
end

