require 'spec_helper'

describe 'COOKBOOK_NAME::default' do
  let(:chef_run) { ChefSpec::ChefRunner.new(RUNNER_OPTS) }
  let(:recipe) { 'COOKBOOK_NAME::default' }

  it 'does some things' do
    raise 'Not yet implemented'
  end
end

# vim: ai et ts=2 sts=2 sw=2 ft=ruby
