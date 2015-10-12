# encoding: UTF-8
# License:: Apache License, Version 2.0
#

require_relative 'spec_helper'

describe file('/etc/repose/merge-header.cfg.xml') do
  it { should be_file }
  it { should be_owned_by 'repose' }
  it { should be_grouped_into 'repose' }
  it { should be_mode 644 }
end
