#!/usr/bin/env rspec

require 'spec_helper'

describe 'monitoringutils' do
  let (:params) { { :scriptpath => '/usr/local/scripts' }}
  it { should contain_class 'monitoringutils' }
end
