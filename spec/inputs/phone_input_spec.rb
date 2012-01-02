# encoding: utf-8
require 'spec_helper'

describe_input :phone, :type => :tel do

  it_behaves_like "a stringish input"
  
end
