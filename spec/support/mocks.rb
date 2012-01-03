# encoding: utf-8
module Mocks

  def mock_main_model
    parent = ::ParentModel.new
    parent.mock_column(:test_attribute)
    ::ParentModel.stub(:content_columns).and_return([mock('column', :name => 'test_attribute')])
    parent.save(42)

    main = ::MainModel.new
    main.mock_column(:test_attribute)
    ::MainModel.stub(:content_columns).and_return([mock('column', :name => 'test_attribute')])
    main.stub(:parent_model).and_return(parent)
    main.stub(:parent_model_id).and_return(parent.id)

    main
  end

end