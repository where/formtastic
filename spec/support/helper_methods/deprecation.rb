# encoding: utf-8
module HelperMethods

  def with_deprecation_silenced
    ::ActiveSupport::Deprecation.silence do
      yield
    end
  end

end
