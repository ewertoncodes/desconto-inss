require 'ffaker'

# Função para gerar salários aleatórios dentro de faixas específicas
def generate_random_salary(min, max)
  rand(min..max).round(2)
end

# Quantidades desejadas por faixa salarial (invertido)
salaries = {
  'Até R$ 1.045,00': 601,
  'De R$ 1.045,01 a R$ 2.089,60': 193,
  'De R$ 2.089,61 até R$ 3.134,40': 198,
  'De R$ 3.134,41 até R$ 6.101,06': 8
}

# Função para criar proponents com salários aleatórios dentro das faixas especificadas
def create_proponents_with_salaries(count, salary_range)
  count.times do
    salary = generate_random_salary(salary_range[:min], salary_range[:max])
    Proponent.create!(
      name: FFaker::Name.name,
      cpf: FFaker::IdentificationBR.cpf,
      birth_date: FFaker::Time.between(65.years.ago, 18.years.ago).to_date,
      street: FFaker::Address.street_name,
      number: FFaker::Address.building_number,
      neighborhood: FFaker::AddressUS.neighborhood,
      city: FFaker::Address.city,
      state: FFaker::AddressUS.state_abbr,
      zip_code: FFaker::AddressUS.zip_code,
      personal_phone: FFaker::PhoneNumberBR.phone_number,
      reference_phone: FFaker::PhoneNumberBR.phone_number,
      salary: salary
    )
  end
end

# Criar proponents com os números especificados para cada faixa salarial
create_proponents_with_salaries(601, min: 0, max: 1045.00)
create_proponents_with_salaries(193, min: 1045.01, max: 2089.60)
create_proponents_with_salaries(198, min: 2089.61, max: 3134.40)
create_proponents_with_salaries(8, min: 3134.41, max: 6101.06)
