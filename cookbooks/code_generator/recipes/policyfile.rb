# Encoding: UTF-8
#
# Cookbook Name:: code_generator
# Recipe:: policyfile
#

context = ChefDK::Generator.context
policyfile_path = File.join(context.policyfile_dir,
                            "#{context.new_file_basename}.rb")

template policyfile_path do
  source 'Policyfile.rb.erb'
  helpers(ChefDK::Generator::TemplateHelper)
end
