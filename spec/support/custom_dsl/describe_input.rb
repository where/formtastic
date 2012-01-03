# encoding: utf-8
module CustomDSL

  def describe_input(input_type, options={}, &examples)
    describe "#{input_type} input" do
      before { @output_buffer = '' }

      let(:form_options) { {} }
      let(:input_options) { {} }
      
      let(:model_object) { options[:model_object] || mock_main_model }
      let(:input_element) { options[:element] || :input }
      let(:html_type) { options.key?(:type) ? options[:type] : input_type }
      let(:input_type) { input_type }

      subject { render_input }
    end.class_eval &examples
  end
  
end