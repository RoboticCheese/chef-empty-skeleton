Code Generator Cookbook
=======================

A customized version of the generator cookbook included with Chef-DK.

Requirements
============

This cookbook operates standalone with no cookbook dependencies.

Customizations
==============

* Use a fuller README template for cookbooks
* Add a CHANGELOG for cookbooks
* Add a Gemfile for cookbooks
* Add a Rakefile for cookbooks
* Add a ChefSpec skeleton and `spec_helper` file for cookbooks
* Add a ServerSpec skeleton and `spec_helper` for cookbooks
* Add a `.kitchen.travis.yml` Kitchen config for TravisCI for cookbooks
* Add a blank `.env.sh` file for DigitalOcean credential env variables for
  cookbooks
* Use attributes in place of certain command line switches (see below)
* Create an example attribute set to nil for attributes
* Place encoding comments in all generated Ruby files

Recipes
=======

This cookbook contains a generator recipe for each Chef structure supported by
`chef generate`.

***app***

***attribute***

***cookbook***

***cookbook_file***

***lwrp***

***policyfile***

***recipe***

***repo***

***template***

Attributes
==========

This cookbook uses a set of attributes for certain options to save having to
pass them to `chef generate` every time.

***default***

    default['code_generator']['copyright_holder'] = 'Jonathan Hartman'
    default['code_generator']['username'] = 'RoboticCheese'
    default['code_generator']['email'] = 'j@p4nt5.com'
    default['code_generator']['license'] = 'apachev2'

License & Authors
=================
- Author: Jonathan Hartman <j@p4nt5.com>

Copyright 2014 Jonathan Hartman

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
