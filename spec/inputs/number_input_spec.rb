# encoding: utf-8
require 'spec_helper'

describe_input :number do  
  
  it_behaves_like "a numeric input" do
    let(:default_step) { "any" }
  end

  it_behaves_like "an input with placeholder"

end

