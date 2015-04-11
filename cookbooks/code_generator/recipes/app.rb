# Encoding: UTF-8
#
# Cookbook Name:: code_generator
# Recipe:: app
#

context = ChefDK::Generator.context
app_dir = File.join(context.app_root, context.app_name)
cookbooks_dir = context.cookbook_root
cookbook_dir = File.join(cookbooks_dir, context.app_name)

# app root dir
directory app_dir

# Top level files

# ServerSpec
directory "#{cookbook_dir}/test/integration/default/serverspec" do
  recursive true
end
cf = "#{cookbook_dir}/test/integration/default/serverspec/spec_helper.rb"
cookbook_file cf do
  source 'spec_helper.serverspec.rb'
  action :create_if_missing
end
t = "#{cookbook_dir}/test/integration/default/serverspec/default_spec.rb"
template t do
  source 'serverspec_spec.rb.erb'
  variables(spec_name: 'default')
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# TK
template "#{app_dir}/.kitchen.yml" do
  source 'kitchen.yml.erb'
  helpers(ChefDK::Generator::TemplateHelper)
end

# README, CHANGELOG, and CoC
%w(README CHANGELOG CODE_OF_CONDUCT).each do |f|
  template "#{app_dir}/#{f}.md" do
    helpers(ChefDK::Generator::TemplateHelper)
  end
end

# Generated Cookbook:

# cookbook collection dir
directory cookbooks_dir

# cookbook collection dir
directory cookbook_dir

# metadata.rb
template "#{cookbook_dir}/metadata.rb" do
  helpers(ChefDK::Generator::TemplateHelper)
end

# chefignore
cookbook_file "#{cookbook_dir}/chefignore"

# Berks
cookbook_file "#{cookbook_dir}/Berksfile"

# Recipes

directory "#{cookbook_dir}/recipes"

template "#{cookbook_dir}/recipes/default.rb" do
  source 'recipe.rb.erb'
  helpers(ChefDK::Generator::TemplateHelper)
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

# git
if context.have_git
  execute('initialize-git') do
    command('git init .')
    cwd app_dir
  end

  cookbook_file "#{app_dir}/.gitignore" do
    source 'gitignore'
  end
end
