# encoding: utf-8
require "rspec_tag_matchers"

module CustomMatchers
  def have_element(element)
    ElementMatcher.new(element)
  end
  
  class ElementMatcher < ::RspecTagMatchers::HaveTag
    def initialize(element)
      @element = element
      @attributes = {}
      @classes = []
      super(element, nil, {})
    end

    def matches?(content)
      @selector = "#{element_selector}#{classes_selector}#{attributes_selector}"
      super
    end

    def description
      "have a #{@element} tag with #{@attributes.merge({:class => @classes}).inspect}"
    end

    def with_attributes(attributes)
      attributes = {attributes => true} unless attributes.is_a?(Hash)
      @attributes.reverse_merge! attributes
      self
    end
    alias_method :with_attribute, :with_attributes

    def with_classes(*classes)
      @classes += classes
      self
    end
    alias_method :with_class, :with_classes

    def with_text(string_or_regex)
      @inner_text = string_or_regex
      self
    end

    [:attribute, :attributes, :class, :classes, :text].each do |method|
      alias_method :"and_#{method}", :"with_#{method}"
    end

    def method_missing(method, *args, &block)
      attribute = method.to_s.sub(/^(with|and)_/, "").to_sym
      case args.length
      when 0
        with_attributes(attribute)
      when 1
        with_attributes(attribute => args.first)
      else
        super
      end
    end

    def element_selector
      @element
    end

    def attributes_selector
      @attributes.map{|k, v| "[#{k}#{%Q(="#{v}") unless v == true}]" unless v.nil? }.join
    end

    def classes_selector
      @classes.compact.map{|c| ".#{c}"}.join
    end

  end
end