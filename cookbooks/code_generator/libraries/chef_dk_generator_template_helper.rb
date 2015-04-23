# Encoding: UTF-8
#
# Cookbook Name:: code_generator
# Library:: chef_dk_generator_template_helper
#
# Copyright 2014-2015, Jonathan Hartman
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
      def project_name
        return app_name if defined?(app_name)
        return repo_name if defined?(repo_name)
        return cookbook_name if defined?(cookbook_name)
      end

      def project_description
        n = project_name.split('-').map(&:capitalize).join(' ')
        return n << ' App' if defined?(app_name)
        return n << ' Repo' if defined?(repo_name)
        return n << ' Cookbook' if defined?(cookbook_name)
      end

      def attribute_name
        defined?(new_file_basename) ? new_file_basename : 'default'
      end

      def attribute_namespace
        cookbook_name.gsub('-', '_')
      end

      [:copyright_holder, :username, :email, :license].each do |i|
        define_method(i) { node['code_generator'][i] }
      end

      def badges
        badge_headers << "\n" << badge_links
      end

      private

      def badge_headers
        <<-EOH.gsub(/^ +/, '')
          #{cookbook_badge[:badge]}
          #{build_badge[:badge]}
          #{style_badge[:badge]}
          #{coverage_badge[:badge]}
        EOH
      end

      def badge_links
        <<-EOH.gsub(/^ +/, '')
          #{cookbook_badge[:target]}
          #{build_badge[:target]}
          #{style_badge[:target]}
          #{coverage_badge[:target]}
        EOH
      end

      def cookbook_badge
        { badge: '[![Cookbook Version](https://img.shields.io/cookbook/v' \
                 "/#{cookbook_name}.svg)][cookbook]",
          target: '[cookbook]: https://supermarket.chef.io/cookbooks' \
                  "/#{cookbook_name}" }
      end

      def build_badge
        { badge: "[![Build Status](https://img.shields.io/travis/#{username}" \
                 "/#{cookbook_name}-chef.svg)][travis]",
          target: "[travis]: https://travis-ci.org/#{username}" \
                  "/#{cookbook_name}-chef" }
      end

      def style_badge
        { badge: '[![Code Climate](https://img.shields.io/codeclimate/github' \
                 "/#{username}/#{cookbook_name}-chef.svg)][codeclimate]",
          target: "[codeclimate]: https://codeclimate.com/github/#{username}" \
                  "/#{cookbook_name}-chef" }
      end

      def coverage_badge
        { badge: '[![Coverage Status](https://img.shields.io/coveralls' \
                 "/#{username}/#{cookbook_name}-chef.svg)][coveralls]",
          target: "[coveralls]: https://coveralls.io/r/#{username}" \
                  "/#{cookbook_name}-chef" }
      end
    end
  end
end
