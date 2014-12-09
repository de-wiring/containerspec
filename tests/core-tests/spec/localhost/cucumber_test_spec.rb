require 'spec_helper'

describe 'Valid scenarios should pass' do
  describe command 'cucumber --tags @Valid' do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /^11 scenarios.*11 passed/ }
  end
  describe command 'cucumber --tags @Valid --tags @SampleImage' do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /^1 scenario.*1 passed/ }
  end
end

describe 'Invalid scenarios have to fail' do
  describe command 'cucumber --tags @Invalid' do
    its(:exit_status) { should eq 1 }
    its(:stdout) { should match /^39 scenarios.*39 failed/ }
  end
  describe command 'cucumber --tags @Invalid --tags @SampleImage' do
    its(:exit_status) { should eq 1 }
    its(:stdout) { should match /^13 scenarios.*13 failed/ }
  end
end
