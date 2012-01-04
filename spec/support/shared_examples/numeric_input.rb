# encoding: utf-8
shared_examples_for "a numeric input" do

  it_behaves_like "a basic input"

  it "applies numeric and stringish classes to the wrapper" do
    should have_wrapper.with_classes(:numeric, :stringish)
  end

  it "does not apply the size attribute" do
    should_not have_input.with_size
  end

  {:value => 2, :proc => lambda {|o| 2}}.each do |validator_type, validator_value|
    describe "when a :greater_than validation is set to a #{validator_type}" do
      before { add_numericality_validator(:only_integer => false, :allow_nil => false, :greater_than => validator_value) }

      it_behaves_like "a numeric input with minimum value options"

      describe "and the column is an integer" do
        before { set_column_type(:integer) }
        
        it "adds a min attribute to the input one greater than the validation" do
          should have_input.with_min(3)
        end
      end
      
      [:decimal, :float].each do |column_type|
        describe "and the column is a #{column_type}" do
          before { set_column_type(column_type) }
          
          it "raises an error" do
            expect { render_input }.to raise_error(Formtastic::Inputs::Base::Validations::IndeterminableMinimumAttributeError)
          end
        end
      end

      pending "and there is no column" do
        before { set_column_type(nil) }

        it "raises an error" do
          expect { render_input }.to raise_error(Formtastic::Inputs::Base::Validations::IndeterminableMinimumAttributeError)
        end
      end
    end

    describe "when a :greater_than_or_equal_to validation is set to a #{validator_type}" do
      before { add_numericality_validator(:only_integer => false, :allow_nil => false, :greater_than_or_equal_to => validator_value) }

      it_behaves_like "a numeric input with minimum value options"

      [:integer, :decimal, :float].each do |column_type|
        describe "and the column is a #{column_type}" do
          before { set_column_type(column_type) }

          it "adds a max attribute to the input equal to the validation" do
            should have_input.with_min(2)
          end
        end
      end

      describe "and there is no column" do
        before { set_column_type(nil) }
      
        it "adds a max attribute to the input equal to the validation" do
          should have_input.with_min(2)
        end
      end
    end

    describe "when a :less_than validation is set to a #{validator_type}" do
      before { add_numericality_validator(:only_integer => false, :allow_nil => false, :less_than => validator_value) }

      it_behaves_like "a numeric input with maximum value options"

      describe "and the column is an integer" do
        before { set_column_type(:integer) }
        
        it "adds a max attribute to the input one less than the validation" do
          should have_input.with_max(1)
        end
      end
      
      [:decimal, :float].each do |column_type|
        describe "and the column is a #{column_type}" do
          before { set_column_type(column_type) }
          
          it "raises an error" do
            expect { render_input }.to raise_error(Formtastic::Inputs::Base::Validations::IndeterminableMaximumAttributeError)
          end
        end
      end

      pending "and there is no column" do
        before { set_column_type(nil) }

        it "raises an error" do
          expect { render_input }.to raise_error(Formtastic::Inputs::Base::Validations::IndeterminableMaximumAttributeError)
        end
      end

    end

    describe "when a :less_than_or_equal_to validation is set to a #{validator_type}" do
      before { add_numericality_validator(:only_integer => false, :allow_nil => false, :less_than_or_equal_to => validator_value) }

      it_behaves_like "a numeric input with maximum value options"

      [:integer, :decimal, :float].each do |column_type|
        describe "and the column is a #{column_type}" do
          before { set_column_type(column_type) }

          it "adds a max attribute to the input equal to the validation" do
            should have_input.with_max(2)
          end
        end
      end

      describe "and there is no column" do
        before { set_column_type(nil) }
      
        it "adds a max attribute to the input equal to the validation" do
          should have_input.with_max(2)
        end
      end
    end
  end

  describe "when validations require conflicting minimum values (:greater_than, :greater_than_or_equal_to)" do
    before { add_numericality_validator(:only_integer => false, :allow_nil => false, :greater_than => 20, :greater_than_or_equal_to => 2) }
    
    it "adds a min attribute to the input equal to the :greater_than_or_equal_to validation" do
      should have_input.with_min(2)
    end
  end
  
  describe "when validations require conflicting maximum values (:less_than, :less_than_or_equal_to)" do
    before { add_numericality_validator(:only_integer => false, :allow_nil => false, :less_than => 20, :less_than_or_equal_to => 2) }
    
    it "adds a max attribute to the input equal to the :less_than_or_equal_to validation" do
      should have_input.with_max(2)
    end
  end

  describe "when validations require an integer (:only_integer)" do
    before { add_numericality_validator(:only_integer => true, :allow_nil => false) }

    it_behaves_like "a numeric input with step value options"

    it "adds a step attribute to the input with value 1" do
      should have_input.with_step(1)
    end
  end

  describe "when validations require a :step (non standard)" do
    before { add_numericality_validator(:only_integer => false, :allow_nil => false, :step => 2) }

    it_behaves_like "a numeric input with step value options"

    it "adds a step attribute to the input equal to the validation" do
      should have_input.with_step(2)
    end
  end

  describe "when validations do not specify :step (non standard) or :only_integer" do

    it_behaves_like "a numeric input with step value options"

    it "adds a step attribute with default value" do
      should have_input.with_step(default_step)
    end
  end

end


shared_examples_for "a numeric input with minimum value options" do

  describe "when :min is provided in :input_html" do
    let(:input_options) { {:input_html => {:min => 5}} }
  
    it "overrides the validation" do
      should have_input.with_min(5)
    end
  end

  describe "when :in is provided in :input_html" do
    let(:input_options) { {:input_html => {:in => 5..102}} }
  
    it "overrides the validation" do
      should have_input.with_min(5)
    end
  end

  describe "when :min is provided in options" do
    let(:input_options) { {:min => 5} }
  
    it "overrides the validation" do
      should have_input.with_min(5)
    end
  end

  describe "when :in is provided in options" do
    let(:input_options) { {:in => 5..102} }
  
    it "overrides the validation" do
      should have_input.with_min(5)
    end
  end

end


shared_examples_for "a numeric input with maximum value options" do

  describe "when :max is provided in :input_html" do
    let(:input_options) { {:input_html => {:max => 102}} }
  
    it "overrides the validation" do
      should have_input.with_max(102)
    end
  end

  describe "when :in is provided in :input_html" do
    let(:input_options) { {:input_html => {:in => 5..102}} }
  
    it "overrides the validation" do
      should have_input.with_max(102)
    end
  end

  describe "when :max is provided in options" do
    let(:input_options) { {:max => 102} }
  
    it "overrides the validation" do
      should have_input.with_max(102)
    end
  end

  describe "when :in is provided in options" do
    let(:input_options) { {:in => 5..102} }
  
    it "overrides the validation" do
      should have_input.with_max(102)
    end
  end

end


shared_examples_for "a numeric input with step value options" do
  describe "when :step is provided in :input_html" do
    let(:input_options) { {:input_html => {:step => 3}} }
  
    it "overrides the validation" do
      should have_input.with_step(3)
    end
  end

  describe "when :step is provided in options" do
    let(:input_options) { {:step => 3} }
  
    it "overrides the validation" do
      should have_input.with_step(3)
    end
  end
end
