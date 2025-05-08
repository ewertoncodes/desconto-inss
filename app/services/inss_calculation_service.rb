class InssCalculationService
  BRACKETS = [
    { limit: 1045.00, rate: 0.075 },
    { limit: 2089.60, rate: 0.09 },
    { limit: 3134.40, rate: 0.12 },
    { limit: 6101.06, rate: 0.14 }
  ].freeze

  def initialize(gross_salary)
    @gross_salary = gross_salary.to_f
    validate_salary
  end

  def call
    discount = calculate_discount
    {
      discount: discount.round(2),
      net_salary: (@gross_salary - discount).round(2)
    }
  end

  private

  def validate_salary
    if @gross_salary > BRACKETS.last[:limit]
      raise ArgumentError, "Gross salary cannot be greater than #{BRACKETS.last[:limit]}"
    elsif @gross_salary.negative?
      raise ArgumentError, "Gross salary must be positive"
    end
  end

  def calculate_discount
    previous_limit = 0.0
    BRACKETS.sum do |bracket|
      next 0 if @gross_salary <= previous_limit

      current_limit = [ bracket[:limit], @gross_salary ].min
      taxable_amount = current_limit - previous_limit
      previous_limit = bracket[:limit]

      (taxable_amount * bracket[:rate]).round(2)
    end.round(2)
  end
end
