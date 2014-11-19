class ViolationWrapper
  def initialize(violations)
    @violations = Hash.new { [] }

    if violations.present?
      violations.each do |violation|
        @violations[violation.attribute_name] = @violations[violation.attribute_name] << violation
      end
    end
  end

  def [](attribute)
    @violations[attribute].map { |violation| translate_violation(violation) }
  end

  def as_json(options={})
    translated_violations
  end

  protected
    def translate_violation(violation)
      "wrong #{violation.attribute_name}"
    end

    def translated_violations
      @translated_violations ||= Hash[@violations.map { |k,v| [k, v.map { |violation| translate_violation(violation) }] }]
    end
end
