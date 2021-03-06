# encoding: utf-8
# frozen_string_literal: true
#
# Cookbook Name:: code_generator
# Recipe:: cookbook
#

context = ChefDK::Generator.context
cookbook_dir = File.join(context.cookbook_root, context.cookbook_name)

# cookbook root dir
directory cookbook_dir

# Metadata, README, CHANGELOG, and CoC
%w(metadata.rb README.md CHANGELOG.md CODE_OF_CONDUCT.md).each do |f|
  template File.join(cookbook_dir, f) do
    helpers(ChefDK::Generator::TemplateHelper)
    action :create_if_missing
  end
end

# chefignore
cookbook_file "#{cookbook_dir}/chefignore"

%w(Gemfile Rakefile Berksfile Guardfile .travis.yml).each do |f|
  cookbook_file File.join(cookbook_dir, f) do
    action :create_if_missing
  end
end

# RSpec/ChefSpec
directory "#{cookbook_dir}/spec"
cookbook_file "#{cookbook_dir}/spec/spec_helper.rb" do
  source 'spec_helper.chefspec.rb'
  action :create_if_missing
end
directory "#{cookbook_dir}/spec/recipes"
template "#{cookbook_dir}/spec/recipes/default_spec.rb" do
  source 'recipe_spec.rb.erb'
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# ServerSpec
d = ::File.join(cookbook_dir, 'test/integration/default/serverspec')
directory ::File.join(d, 'localhost') do
  recursive true
end
cookbook_file ::File.join(d, 'spec_helper.rb') do
  source 'spec_helper.serverspec.rb'
  action :create_if_missing
end
template ::File.join(d, 'localhost/default_spec.rb') do
  source 'serverspec_spec.rb.erb'
  variables(spec_name: 'default')
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# TK
template "#{cookbook_dir}/.kitchen.yml" do
  source 'kitchen.yml.erb'
  helpers(ChefDK::Generator::TemplateHelper)
  variables(
    driver: 'vagrant',
    provisioner: 'chef_zero',
    platforms: %w(ubuntu-16.04 ubuntu-14.04 centos-7.2 centos-6.8),
    suites: %w(default)
  )
  action :create_if_missing
end

template "#{cookbook_dir}/.kitchen.travis.yml" do
  source 'kitchen.yml.erb'
  variables(driver: 'dokken')
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
