# encoding: utf-8
module HelperMethods

  def add_validator(kind, options={})
    model_object.class.stub!(:validators_on).with(:test_attribute).and_return([
      active_model_validator(kind, [:test_attribute], options)
    ])
  end

  def add_length_validator(options={})
    add_validator(:length, options)
  end

  def add_numericality_validator(options={})
    add_validator(:numericality, options)
  end

  def active_model_validator(kind, attributes, options = {})
    validator = mock("ActiveModel::Validations::#{kind.to_s.camelize}Validator", :attributes => attributes, :options => options)
    validator.stub!(:kind).and_return(kind)
    validator
  end

  def active_model_presence_validator(attributes, options = {})
    active_model_validator(:presence, attributes, options)
  end

  def active_model_length_validator(attributes, options = {})
    active_model_validator(:length, attributes, options)
  end

  def active_model_inclusion_validator(attributes, options = {})
    active_model_validator(:inclusion, attributes, options)
  end

  def active_model_numericality_validator(attributes, options = {})
    active_model_validator(:numericality, attributes, options)
  end

end
