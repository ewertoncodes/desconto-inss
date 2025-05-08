# spec/factories/proponents.rb
FactoryBot.define do
  factory :proponent do
    name { "John Doe" }
    cpf { "91750117002" }
    birth_date { Date.new(1990, 1, 1) }
    street { "123 Main St" }
    number { "1" }
    neighborhood { "Downtown" }
    city { "Cityville" }
    state { "ST" }
    zip_code { "12345-678" }
    personal_phone { "999999999" }
    reference_phone { "888888888" }
    salary { 5000.0 }
  end
end
