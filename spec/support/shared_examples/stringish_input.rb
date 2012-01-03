# encoding: utf-8
shared_examples_for "a stringish input" do

  it_behaves_like "a basic input"
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

  describe "size attribute" do
    describe "when default_text_field_size is set" do
      set_config(:default_text_field_size, 30)

      it "is equal to the default" do
        should have_input.with_size(30)
      end

      describe "and :size provided in :input_html" do
        let(:input_options) { {:input_html => {:size => 20}} }

        it "overrides the default" do
          should have_input.with_size(20)
        end

        describe "and is nil" do
          let(:input_options) { {:input_html => {:size => nil}} }

          it "suppresses the attribute" do
            should_not have_input.with_size
          end
        end
      end
    end

    describe "when default_text_field_size is nil" do
      set_config(:default_text_field_size, nil)

      it "suppresses the attribute" do
        should_not have_input.with_size
      end

      describe "and :size provided in :input_html" do
        let(:input_options) { {:input_html => {:size => 20}} }

        it "overrides the default" do
          should have_input.with_size(20)
        end

        describe "and is nil" do
          let(:input_options) { {:input_html => {:size => nil}} }

          it "suppresses the attribute" do
            should_not have_input.with_size
          end
        end
      end
    end
  end

  describe "when validates" do
    before { set_column_type(:string, :limit => 50) }

    [:is, :maximum].each do |bound|
      with_length_validator(bound => 42) do
        when_applicable_it "adds a maxlength attribute equal to the validation" do
          should have_input.with_maxlength(42)
        end

        when_not_applicable_it "retains the default maxlength" do
          should have_input.with_maxlength(50)
        end
      end
    end

    with_length_validator(:minimum => 42) do
      when_applicable_it "retains the default maxlength" do
        should have_input.with_maxlength(50)
      end

      when_not_applicable_it "retains the default maxlength" do
        should have_input.with_maxlength(50)
      end
    end

    [:in, :within].each do |range|
      with_length_validator(range => 24..42) do
        when_applicable_it "adds a maxlength attribute equal to the validation" do
          should have_input.with_maxlength(42)
        end

        when_not_applicable_it "retains the default maxlength" do
          should have_input.with_maxlength(50)
        end
      end
    end

  end

end
