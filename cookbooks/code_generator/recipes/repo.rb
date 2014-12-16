# Encoding: UTF-8
#
# Cookbook Name:: code_generator
# Recipe:: repo
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
repo_dir = File.join(context.repo_root, context.repo_name)

# repo root dir
directory repo_dir

# Top level files
template "#{repo_dir}/LICENSE" do
  source "LICENSE.#{context.license}.erb"
  helpers(ChefDK::Generator::TemplateHelper)
end

cookbook_file "#{repo_dir}/README.md" do
  source 'repo/README.md'
end

cookbook_file "#{repo_dir}/Rakefile" do
  source 'repo/Rakefile'
end

cookbook_file "#{repo_dir}/chefignore" do
  source 'chefignore'
end

directory "#{repo_dir}/config"

template "#{repo_dir}/config/rake.rb" do
  source 'repo/config/rake.rb.erb'
  helpers(ChefDK::Generator::TemplateHelper)
end

%w(certificates data_bags environments roles).each do |tlo|
  directory "#{repo_dir}/#{tlo}"

  cookbook_file "#{repo_dir}/#{tlo}/README.md" do
    source "repo/#{tlo}/README.md"
  end
end

directory "#{repo_dir}/cookbooks"

cookbook_file "#{repo_dir}/cookbooks/README.md" do
  if context.policy_only
    source 'repo/cookbooks/README-policy.md'
  else
    source 'repo/cookbooks/README.md'
  end
end

# git
if context.have_git
  execute('initialize-git') do
    command('git init .')
    cwd repo_dir
    not_if { "#{repo_dir}/.gitignore" }
  end

  template "#{repo_dir}/.gitignore" do
    source 'repo/gitignore.erb'
    helpers(ChefDK::Generator::TemplateHelper)
  end
end
