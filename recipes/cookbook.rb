# Encoding: UTF-8
#
# Cookbook Name:: code_generator
# Recipe:: cookbook
#
# Copyright 2014, Jonathan Hartman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

context = ChefDK::Generator.context
cookbook_dir = File.join(context.cookbook_root, context.cookbook_name)

# cookbook root dir
directory cookbook_dir

%w(metadata.rb README.md CHANGELOG.md).each do |f|
  template File.join(cookbook_dir, f) do
    helpers(ChefDK::Generator::TemplateHelper)
    action :create_if_missing
  end
end

# chefignore
cookbook_file "#{cookbook_dir}/chefignore"

# Bundler
cookbook_file "#{cookbook_dir}/Gemfile" do
  action :create_if_missing
end

# Rake
cookbook_file "#{cookbook_dir}/Rakefile" do
  action :create_if_missing
end
directory "#{cookbook_dir}/test"
cookbook_file "#{cookbook_dir}/test/knife.rb" do
  action :create_if_missing
end

# Berks
cookbook_file "#{cookbook_dir}/Berksfile" do
  action :create_if_missing
end

# Guard
cookbook_file "#{cookbook_dir}/Guardfile" do
  action :create_if_missing
end

# RSpec/ChefSpec
directory "#{cookbook_dir}/spec"
cookbook_file "#{cookbook_dir}/spec/spec_helper.rb" do
  source 'spec_helper.chefspec.rb'
  action :create_if_missing
end
directory "#{cookbook_dir}/spec/recipes"
template "#{cookbook_dir}/spec/recipes/default_spec.rb" do
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# ServerSpec
directory "#{cookbook_dir}/test/integration/default/serverspec" do
  recursive true
end
cf = "#{cookbook_dir}/test/integration/default/serverspec/spec_helper.rb"
cookbook_file cf do
  source 'spec_helper.serverspec.rb'
  action :create_if_missing
end

# TK
template "#{cookbook_dir}/.kitchen.yml" do
  source 'kitchen.yml.erb'
  helpers(ChefDK::Generator::TemplateHelper)
  variables(
    driver: 'vagrant',
    provisioner: 'chef_zero',
    platforms: %w(ubuntu-14.04 ubuntu-12.04 centos-6.5 centos-5.11),
    suites: %w(default)
  )
  action :create_if_missing
end

template "#{cookbook_dir}/.kitchen.travis.yml" do
  source 'kitchen.yml.erb'
  variables(driver: 'digitalocean')
  action :create_if_missing
end

# Test environment variables
cookbook_file "#{cookbook_dir}/.env.sh" do
  action :create_if_missing
end

# Recipes

directory "#{cookbook_dir}/recipes"

template "#{cookbook_dir}/recipes/default.rb" do
  source 'recipe.rb.erb'
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# git
if context.have_git
  unless context.skip_git_init
    execute('initialize-git') do
      command('git init .')
      cwd cookbook_dir
    end
  end

  cookbook_file "#{cookbook_dir}/.gitignore" do
    source 'gitignore'
  end
end
