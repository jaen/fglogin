class FormObject
  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion

  def persisted?
    false
  end

  def valid?
    validate! && @validation.valid?
  end

  def errors
    ViolationWrapper.new(@validation && @validation.violations)
  end

  protected
    def validate!
      @validation = self.class::VALIDATOR.call(self)
    end
end
