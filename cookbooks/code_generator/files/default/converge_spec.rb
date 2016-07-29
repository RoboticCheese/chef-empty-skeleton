# encoding: utf-8
# frozen_string_literal: true

require_relative '../spec_helper'

describe 'demo::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge('demo::default') }

  it 'converges successfully' do
    chef_run # This should not raise an error
  end
end
