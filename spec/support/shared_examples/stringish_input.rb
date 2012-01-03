# encoding: utf-8
shared_examples_for "a stringish input" do

  it_behaves_like "an input"
  it_behaves_like "an input with placeholder"

  it "applies stringish class to the wrapper" do
    should have_wrapper.with_class(:stringish)
  end

  describe "maxlength attribute" do
    before { set_column_type(:string, :limit => 50) }

    describe "when :maxlength not provided" do
      it "is equal to the column limit" do
        should have_input.with_maxlength(50)
      end
    end

    describe "when :maxlength provided in :input_html" do
      let(:input_options) { {:input_html => {:maxlength => 25}} }

      it "overrides the column limit" do
        should have_input.with_maxlength(25)
      end
    end
  end

end
