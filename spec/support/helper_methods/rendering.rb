# encoding: utf-8
module HelperMethods

  def render_form(&contents)
    concat(semantic_form_for(model_object, form_options, &contents))
    output_buffer
  end

  def render_input
    render_form &input_renderer
  end

  def input_renderer
    lambda {|builder| concat(builder.input(:test_attribute, input_options.merge(:as => input_type)))}
  end

end
