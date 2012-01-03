# encoding: utf-8
module CustomMacros
    
  def with_country_select_installed(&examples)
    describe "when country_select is available as a helper from a plugin" do
      before(:all) do
        Formtastic::FormBuilder.class_eval do
          def country_select(method, priority_countries=nil, options={}, html_options={})
            select(method, ["..."], options, html_options)
          end
        end
      end

      after(:all) do
        Formtastic::FormBuilder.class_eval do
          remove_method :country_select
        end
      end
    end.class_eval &examples
  end

  def without_country_select_installed(&examples)
    describe("when country_select is not available as a helper from a plugin", &examples)
  end

end