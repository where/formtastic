# encoding: utf-8
class ParentModel < Mocks::MockModel
  def self.reflect_on_association(name)
    case name
    when :main_model
      mock('reflection', :options => {}, :klass => MainModel, :macro => :has_many)
    end
  end  
end

def parent_model_path(*args)
  "/parent_models/1"
end

def parent_models_path(*args)
  "/parent_model"
end

def new_parent_model_path(*args)
  "/parent_models/new"
end