# encoding: utf-8
module CustomMacros

  def with_namespace(namespace, &examples)
    describe "when namespace is provided" do
      let(:form_options) { {:namespace => namespace} }
    end.class_eval &examples
  end

end
