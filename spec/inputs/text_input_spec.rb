# encoding: utf-8
require 'spec_helper'

describe_input :text, :element => :textarea do

  it_behaves_like "a basic input"
  it_behaves_like "an input with placeholder"

  [:cols, :rows].each do |attribute|
    describe "when #{attribute.inspect} is provided in :input_html" do
      let(:input_options) { {:input_html => {attribute => 42}} }

      it "adds a #{attribute} attribute with the specified value" do
        should have_input.with_attribute(attribute => 42)
      end

      describe "and is nil" do
        let(:input_options) { {:input_html => {attribute => nil}} }

        it "does not add a #{attribute} attribute" do
          should_not have_input.with_attribute(attribute)
        end
      end
    end
  end

  describe "when :cols is not provided in :input_html" do
    describe "and default_text_area_width is set" do
      set_config :default_text_area_width, 12
      
      it "adds a cols attribute with the default_text_area_width value" do
        should have_input.with_cols(12)
      end
    end

    describe "and default_text_area_width is nil" do
      set_config :default_text_area_width, nil
      
      it "does not add a cols attribute" do
        should_not have_input.with_cols
      end
    end
  end

  describe "when :rows is not provided in :input_html" do
    describe "and default_text_area_height is set" do
      set_config :default_text_area_height, 12
      
      it "adds a rows attribute with the default_text_area_height value" do
        should have_input.with_rows(12)
      end
    end

    describe "and default_text_area_height is nil" do
      set_config :default_text_area_height, nil
      
      it "does not add a rows attribute" do
        should_not have_input.with_rows
      end
    end
  end

end

