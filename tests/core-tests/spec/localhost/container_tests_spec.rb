require 'spec_helper'

describe 'Valid container scenarios should pass' do
  describe command 'cucumber --tags @Containers --tags @Valid' do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /^9 scenarios.*9 passed/ }
  end
end

describe 'Invalid containerscenarios have to fail' do
  describe command 'cucumber --tags @Containers --tags @Invalid' do
    its(:exit_status) { should eq 1 }
    its(:stdout) { should match /^20 scenarios.*20 failed/ }
  end
end
