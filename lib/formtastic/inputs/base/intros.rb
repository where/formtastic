module Formtastic
  module Inputs
    module Base
      module Intros
        
        def intro_html
          if intro?
            template.content_tag(
              :p, 
              Formtastic::Util.html_safe(intro_text), 
              :class => builder.default_intro_class
            )
          end
        end

        def intro?
          !intro_text.blank? && !intro_text.kind_of?(Hash)
        end
        
        def intro_text
          localized_string(method, options[:intro], :intro)
        end
        
        def intro_text_from_options
          options[:intro]
        end

      end
    end
  end
end
