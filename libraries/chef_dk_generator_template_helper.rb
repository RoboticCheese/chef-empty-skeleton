# Encoding: UTF-8
#
# Cookbook Name:: code_generator
# Library:: chef_dk_generator_template_helper
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

module ChefDK
  module Generator
    # A monkey patch to add some extra TemplateHelper methods
    #
    # @author Jonathan Hartman <j@p4nt5.com>
    module TemplateHelper
      def recipe_name
        defined?(new_file_basename) ? new_file_basename : 'default'
      end
      alias_method :attribute_name, :recipe_name

      def attribute_namespace
        cookbook_name.gsub('-', '_')
      end
    end
  end
end
