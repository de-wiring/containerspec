require 'spec_helper'

describe 'Valid container scenarios should pass' do
  describe command 'cucumber --tags @Containers --tags @Valid' do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /^6 scenarios.*6 passed/ }
  end
end

describe 'Invalid containerscenarios have to fail' do
  describe command 'cucumber --tags @Containers --tags @Invalid' do
    its(:exit_status) { should eq 1 }
    its(:stdout) { should match /^15 scenarios.*15 failed/ }
  end
end
