# encoding: utf-8
module Mocks
  class MockModel
    extend ActiveModel::Naming
    include ActiveModel::Conversion

    def mock(*args)
      RSpec::Mocks::Mock.new(*args)
    end

    def mock_column(name, options={})
      options.reverse_merge!(:type => :string)
      stub(name)
      stub(:"#{name}=")
      stub(:column_for_attribute).with(name).and_return(mock('column', options))
    end

    def mock_association(name, options={})
      options.reverse_merge!(:options => {})
      self.class.stub(:reflect_on_association).with(name).and_return(mock('reflection', options))
    end

    def add_validator(attribute, kind, options={})
      validator = mock("ActiveModel::Validations::#{kind.to_s.camelize}Validator", :attributes => attributes, :options => options)
      validator.stub(:kind).and_return(kind)

      stub(:validators_on).with(attribute).and_return([validator])
    end

    def add_numericality_validator(attribute, options={})
      add_validator(attribute, :numericality, options)
    end

    def id
    end

    def persisted?
      false
    end

    def new_record?
      true
    end

    def errors(*args)
      {}
    end

    def reflect_on_association(*args)
    end

    def save(id)
      stub(:id).and_return(id)
      stub(:new_record?).and_return(false)
    end

    def self.scoped
      self
    end

    def self.human_attribute_name(attribute)
      attribute.humanize
    end

    def self.human_name
      self.class.name
    end

    def self.reflect_on_all_validations(*args)
      []
    end

    def self.reflect_on_validations_for(*args)
      []
    end

    def self.reflections(*args)
      {}
    end
  end
end