# encoding: utf-8
module CustomMacros

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
