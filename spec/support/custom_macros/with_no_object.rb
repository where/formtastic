# encoding: utf-8
module CustomMacros

  def with_no_object(&examples)
    describe "when no object is provided" do
      let(:model_object) { :main_model }
      let(:form_options) { {:url => 'http://test.host/'} }
    end.class_eval &examples
  end

end
