shared_examples_for "an input" do

  it_behaves_like "a wrapped input"

  it_behaves_like "a labelled input"

  with_no_object do
    it_behaves_like "a labelled input"
  end

  describe "when :input_html is provided" do
    let(:input_options) { {:input_html => {:class => "myclass"}} }
    
    it "applies custom attributes to the input" do
      should have_input.with_class("myclass")
    end

    describe "and it includes :id" do
      let(:input_options) { {:input_html => {:id => "myid"}} }

      it "customises the for attribute on the label" do
        should have_label.for("myid")
      end
    end

  end

  describe "when required" do
    let(:input_options) { {:required => true} }

    describe "and configured to generate HTML5 required attributes" do
      set_config :use_required_attribute, true

      it "applies an HTML5 required attribute to the input" do
        should have_input.with_required
      end
    end

    describe "and configured to not generate HTML5 required attributes" do
      set_config :use_required_attribute, false

      it "applies an HTML5 required attribute to the input" do
        should_not have_input.with_required
      end
    end

  end

  with_namespace(:context2) do
    it "customises the input id" do
      should have_input.with_id("context2_main_model_test_attribute")
    end

    it "customises the label for attribute" do
      should have_label.for("context2_main_model_test_attribute")
    end
  end

  with_index(3) do
    it "indexes the id and name of the input tag" do
      should have_input.with_id("main_model_parent_model_attributes_3_test_attribute").and_name("main_model[parent_model_attributes][3][test_attribute]")
    end    
  end

end