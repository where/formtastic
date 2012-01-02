# encoding: utf-8
module CustomDSL
  def describe_input(input_type, options={}, &examples)
    describe "#{input_type} input" do
      include Mocks

      before { @output_buffer = '' }

      let(:form_options) { {} }
      let(:input_options) { {} }
      
      let(:model_object) { options[:model_object] || mock_main_model }
      let(:input_element) { options[:element] || :input }
      let(:input_attribute) { :test_attribute }
      let(:html_type) { options.key?(:type) ? options[:type] : input_type }
      let(:input_type) { input_type }

      subject { render_input }
    end.class_eval &examples
  end

  def with_no_object(&examples)
    describe "when no object is provided" do
      let(:model_object) { :main_model }
      let(:form_options) { {:url => 'http://test.host/'} }
    end.class_eval &examples
  end

  def with_namespace(namespace, &examples)
    describe "when namespace is provided" do
      let(:form_options) { {:namespace => namespace} }
    end.class_eval &examples
  end

  def with_index(index, &examples)
    describe "when index is provided" do
      subject do
        render_form do |builder|
          concat(builder.fields_for(:parent_model, :index => index, &input_renderer))
        end
      end
    end.class_eval &examples
  end
end

include CustomDSL