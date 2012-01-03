# encoding: utf-8
module CustomMacros
    
  def set_config(config_method_name, value)
    old_value = Formtastic::FormBuilder.send(config_method_name)
    before { Formtastic::FormBuilder.send(:"#{config_method_name}=", value) }
    after { Formtastic::FormBuilder.send(:"#{config_method_name}=", old_value) }
  end

end