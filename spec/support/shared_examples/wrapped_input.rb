shared_examples_for "a wrapped input" do

  it "wraps the input in a list item" do
    should have_wrapper.with_id("post_created_at_input").and_class(input_type)
  end

  with_no_object :post do
    it "wraps the input in a list item" do
      should have_wrapper.with_id("post_created_at_input").and_class(input_type)
    end

    it_behaves_like "an input with no errors"
  end

  with_namespace :context2 do
    it "customises the wrapper id" do
      should have_wrapper.with_id("context2_post_created_at_input")
    end
  end

  with_index :author, :created_at, 3 do
    it "indexes the id of the wrapper" do
      should have_wrapper.with_id("post_author_attributes_3_created_at_input")
    end
  end

  describe "when there are errors on the object for this attribute" do
    let(:attribute_errors) { ['must not be blank', 'must be longer than 10 characters', 'must be awesome'] }
    
    let(:errors) do
      mock('errors').tap do |errors|
        errors.stub!(:[]).with(input_attribute).and_return(attribute_errors)
        Formtastic::FormBuilder.file_metadata_suffixes.each do |suffix|
          errors.stub!(:[]).with("created_at_#{suffix}".to_sym).and_return(nil)
        end
      end
    end

    before { model_object.stub!(:errors).and_return(errors) }

    it "applies an error class to the wrapper" do
      should have_wrapper.with_class("error")
    end

    it "does not wrap the input with the Rails default error wrapping" do
      should_not have_tag("div.fieldWithErrors")
    end

    describe "when FormBuilder.inline_errors is set to :sentence" do
      set_config :inline_errors, :sentence 

      it "renders a paragraph for the errors" do
        should have_tag("form li.error p.inline-errors")
      end
    end

    describe "when FormBuilder.inline_errors is set to :list" do
      set_config :inline_errors, :list

      it "renders an unordered list for the errors" do
        should have_tag("form li.error ul.errors")
      end
    end
  end

  describe "when there are no errors on the object for this attribute" do
    it_behaves_like "an input with no errors"
  end
end


shared_examples_for "an input with no errors" do
  it "does not apply an error class to the wrapper" do
    should_not have_wrapper.with_class("error")
  end

  it "does not render a paragraph for the errors" do
    should_not have_tag("form li.error p.inline-errors")
  end

  it "does not render an unordered list for the errors" do
    should_not have_tag("form li.error ul.errors")
  end
end