shared_examples_for "a labelled input" do

  it "generates an input" do
    should have_input.with_type(html_type).and_id("post_created_at").and_name("post[created_at]")
  end

  it "generates a label for the input" do
    should have_label.for("post_created_at").with_text(/Created at/)
  end
  
end