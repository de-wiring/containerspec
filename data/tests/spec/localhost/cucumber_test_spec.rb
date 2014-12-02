require 'spec_helper'

describe 'Valid scenarios should pass' do
  describe command 'cucumber --tags @Valid' do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /^9 scenarios.*9 passed/ }
  end
end

describe 'Invalid scenarios have to fail' do
  describe command 'cucumber --tags @Invalid' do
    its(:exit_status) { should eq 1 }
    its(:stdout) { should match /^14 scenarios.*14 failed/ }
  end
end