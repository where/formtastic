# encoding: utf-8
shared_examples_for "a labelled input" do

  it "generates an input" do
    should have_input.with_type(html_type).and_id("main_model_test_attribute").and_name("main_model[test_attribute]")
  end

  it "generates a label for the input" do
    should have_label.for("main_model_test_attribute").with_text(/Test attribute/)
  end
  
end