# encoding: utf-8
require 'spec_helper'

describe_input :range do

  it_behaves_like "a numeric input" do
    let(:default_step) { 1 }
  end

  describe "when validations do not require a minimum value" do
    it "defaults to 1" do
      should have_input.with_min(1)
    end
  end

  describe "when validations do not require a maximum value" do
    it "defaults to 100" do
      should have_input.with_max(100)
    end
  end
  
end

