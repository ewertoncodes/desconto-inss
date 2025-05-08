class Proponent < ApplicationRecord
  MAX_SALARY = 6101.06

  SALARY_RANGES = {
    'Até R$ 1.045,00' => 0..1045.00,
    'De R$ 1.045,01 a R$ 2.089,60' => 1045.01..2089.60,
    'De R$ 2.089,61 até R$ 3.134,40' => 2089.61..3134.40,
    'De R$ 3.134,41 até R$ 6.101,06' => 3134.41..MAX_SALARY
  }

  validates :name, :cpf, :birth_date, :street, :number, :neighborhood, :city,
            :state, :zip_code, :personal_phone, :reference_phone, :salary, presence: true
  validates :salary, numericality: { less_than_or_equal_to: MAX_SALARY }
  validate :cpf_must_be_valid

  def cpf_must_be_valid
    errors.add(:cpf, 'não é válido') unless CPF.valid?(cpf)
  end

  def self.i18n_scope
    :activerecord
  end

  def self.salary_range_label(salary)
    SALARY_RANGES.detect { |label, range| range.include?(salary) }&.first
  end

  def self.grouped_by_salary_range
    ranges_count = Hash.new(0)
    all.each do |proponent|
      range_label = salary_range_label(proponent.salary)
      ranges_count[range_label] += 1 if range_label
    end
    ranges_count
  end
end
