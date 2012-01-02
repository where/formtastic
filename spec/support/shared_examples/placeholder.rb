shared_examples_for "an input with placeholder" do

  after { I18n.backend.reload! }
  
  describe "when found in i18n" do
    set_config :i18n_lookups_by_default, true

    before { I18n.backend.store_translations :en, :formtastic => { :placeholders => { input_attribute => "War and Peace" }} }

    it "adds a placeholder containing i18n text" do
      should have_input.with_placeholder("War and Peace")
    end

    describe "and provided in :input_html" do
      let(:input_options) { {:input_html => {:placeholder => "Untitled"}} }
      
      it "overrides the i18n" do
        should have_input.with_placeholder("Untitled")
      end
    end
  end
  
  describe "when not found in i18n" do
    it "does not add a placeholder" do
      should_not have_input.with_placeholder
    end
  end
  
  describe "when provided in :input_html" do
    let(:input_options) { {:input_html => {:placeholder => "Untitled"}} }

    it "adds a placeholder with the specified text" do
      should have_input.with_placeholder("Untitled")
    end
  end

end
