# encoding: utf-8
module CustomMacros

  class WithValidator
    attr_accessor :when_applicable, :when_not_applicable

    def when_applicable_it(description, &example)
      self.when_applicable = {:description => description, :example => example}
    end

    def when_not_applicable_it(description, &example)
      self.when_not_applicable = {:description => description, :example => example}
    end
  end

  def with_validator(kind, options={}, &examples)
    behavior = WithValidator.new
    behavior.instance_eval(&examples)

    options_description = options.keys.map{|key| key.inspect if options[key]}.compact.join(", ").presence || "no options"

    true_conditionals = {"by a value" => true, "from a proc" => lambda {|o| true}, "from a method" => :true_method}
    false_conditionals = {"by a value" => false, "from a proc" => lambda {|o| false}, "from a method" => :false_method}

    describe "with a #{kind} validator with #{options_description} set" do
      before do
        add_validator(kind, options.merge(conditionals))
        model_object.stub(:true_method).and_return(true)
        model_object.stub(:false_method).and_return(false)
      end

      let(:conditionals) { {} }

      it(behavior.when_applicable[:description], &behavior.when_applicable[:example])

      describe "and :if is set to true" do
        true_conditionals.each do |key, value|
          describe key do
            let(:conditionals) { {:if => value} }
            it(behavior.when_applicable[:description], &behavior.when_applicable[:example])
          end
        end
      end

      describe "and :if is set to false" do
        false_conditionals.each do |key, value|
          describe key do
            let(:conditionals) { {:if => value} }
            it(behavior.when_not_applicable[:description], &behavior.when_not_applicable[:example])
          end
        end
      end

      describe "and :unless is set to false" do
        false_conditionals.each do |key, value|
          describe key do
            let(:conditionals) { {:unless => value} }
            it(behavior.when_applicable[:description], &behavior.when_applicable[:example])
          end
        end
      end

      describe "and :unless is set to true" do
        before { model_object.stub(:unless_true).and_return(true) }

        true_conditionals.each do |key, value|
          describe key do
            let(:conditionals) { {:unless => value} }
            it(behavior.when_not_applicable[:description], &behavior.when_not_applicable[:example])
          end
        end
      end
    end
  end

  def with_length_validator(options={}, &examples)
    with_validator(:length, options, &examples)
  end

  def with_numericality_validator(options={}, &examples)
    with_validator(:length, options, &examples)
  end

end