echo == Ensure serverspec is installed
( sudo gem list --local | grep -q serverspec ) || {
        sudo gem install rake -v '10.4.0' --no-rdoc --no-ri
        sudo gem install rspec -v '3.1.0' --no-rdoc --no-ri
        sudo gem install specinfra -v '2.10.2' --no-rdoc --no-ri
        sudo gem install serverspec -v '2.7.1' --no-rdoc --no-ri
}
