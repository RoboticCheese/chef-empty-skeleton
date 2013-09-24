# -*- mode: ruby -*-

ENV['BERKSHELF_PATH'] ||= File.expand_path('.berkshelf')
ENV['CHEF_VERSION'] ||= 'latest'

def boxify(os)
  name = "opscode_#{os}_provisionerless"
  url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/#{name}.box"
  [name, url]
end

Vagrant.configure('2') do |config|
  config.omnibus.chef_version = ENV['CHEF_VERSION']
  config.berkshelf.enabled = true

  %w{centos-6.4 centos-5.9 ubuntu-13.04 ubuntu-12.04}.each do |os|
    config.vm.define os.to_sym do |box|
      box.vm.box, box.vm.box_url = boxify(os)
    end
  end

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe 'COOKBOOK_NAME_test'
  end
end

# vim: ai et ts=2 sts=2 sw=2 ft=ruby
