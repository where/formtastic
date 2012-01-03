# encoding: utf-8
module HelperMethods

  def have_input
    have_element(input_element)
  end

  def have_label
    have_element(:label)
  end

  def have_wrapper
    have_element(:li).with_class(:input)
  end

end
