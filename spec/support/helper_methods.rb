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
    lambda {|builder| concat(builder.input(input_attribute, input_options.merge(:as => input_type)))}
  end

  def add_validator(kind, options={})
    model_object.class.stub!(:validators_on).with(input_attribute).and_return([
      active_model_validator(kind, [input_attribute], options)
    ])
  end

  def add_numericality_validator(options={})
    add_validator(:numericality, options)
  end

  def set_column_type(type)
    column = mock('column', :type => type) if type
    model_object.stub!(:column_for_attribute).with(input_attribute).and_return(column)
  end

  def have_input
    have_element(input_element)
  end

  def have_label
    have_element(:label)
  end

  def have_wrapper
    have_element(:li).with_class(:input)
  end

  def with_deprecation_silenced(&block)
    ::ActiveSupport::Deprecation.silence do
      yield
    end
  end

  def with_config(config_method_name, value, &block)
    old_value = Formtastic::FormBuilder.send(config_method_name)
    Formtastic::FormBuilder.send(:"#{config_method_name}=", value)
    yield
    Formtastic::FormBuilder.send(:"#{config_method_name}=", old_value)
  end

end