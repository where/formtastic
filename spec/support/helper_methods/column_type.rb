# encoding: utf-8
module HelperMethods

  def set_column_type(type, options={})
    column = mock('column', options.merge(:type => type)) if type
    model_object.stub(:column_for_attribute).with(:test_attribute).and_return(column)
  end

end
