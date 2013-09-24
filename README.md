[![Build Status](http://null)](http://null)

Description
===========

Requirements
============

Recipes
=======

default
-------

Attributes
==========

Data Bags
=========

Usage
=====

Testing
=======
This cookbook should always pass all syntax and lint tests.

The `spec` directory contains [ChefSpec](https://github.com/acrmp/chefspec) 
unit tests for each recipe.

Some commands that may come in handy:

    rake --tasks

See available test tasks that can be run individually.

    bundle install
    rake

Install and run all test tasks in sequence against the Gem versions in
`Gemfile`/`Gemfile.lock`.

    rake appraisal:install
    rake appraisal

Install and run all test tasks in sequence against the Gem sets defined in
`Appraisals`/`gemfiles/*`.

    rake appraisal:gemfiles

Regenerate `gemfiles/*` based on the Gem sets defined in `Appraisals`.

Contributing
============
Pull requests are welcome!

1. Fork the repository on Github
2. Create a named feature branch (`git checkout -b my-new-feature`)
3. Write you change
4. Write tests for your change
5. Run the tests, ensuring they all pass
6. Commit your changes (`git commit -am 'Add some feature'`)
7. Push the branch to GitHub (`git push origin my-new-feature`)
8. Submit a Pull Request using Github

# License and Authors

- Author:: Jonathan Hartman (<j@p4nt5.com>)

- Copyright:: 2013, Jonathan Hartman

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
