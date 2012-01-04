# encoding: utf-8
require 'spec_helper'

describe_input :country, :element => :select do

  without_country_select_installed do

    it "raises an error suggesting the author installs a plugin" do
      expect { render_input }.to raise_error(RuntimeError, /please install a country_select plugin/)
    end

  end

  with_country_select_installed do

    it_behaves_like "a basic input"

    describe "when :priority_countries option is provided" do
      let(:input_options) { {:priority_countries => ["Foo", "Bar"]} }

      it "is passed down to the helper" do
        Formtastic::FormBuilder.any_instance.should_receive(:country_select).with(:test_attribute, ["Foo", "Bar"], {}, {:id => "main_model_test_attribute", :required => false, :autofocus => false})
        render_input
      end
    end 

    describe "when :priority_countries option is not provided" do
      set_config(:priority_countries, ["Baz"])

      it "is defaults to the priority_countries config option" do
        Formtastic::FormBuilder.any_instance.should_receive(:country_select).with(:test_attribute, ["Baz"], {}, {:id => "main_model_test_attribute", :required => false, :autofocus => false})
        render_input
      end
    end

  end
end
