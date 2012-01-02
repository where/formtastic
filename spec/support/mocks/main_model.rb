# encoding: utf-8
class MainModel < Mocks::MockModel
  def parent_model(*args)
  end

  def parent_model_id
  end

  def parent_model_attributes=(*args)
  end

  def self.reflect_on_association(name)
    case name
    when :parent_model
      mock('reflection', :options => {}, :klass => ParentModel, :macro => :belongs_to)
    end
  end
end

def main_model_path(*args)
  "/main_models/1"
end

def main_models_path(*args)
  "/main_model"
end

def new_main_model_path(*args)
  "/main_models/new"
end