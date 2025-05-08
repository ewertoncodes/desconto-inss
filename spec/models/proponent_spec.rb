require 'rails_helper'

RSpec.describe Proponent, type: :model do
  let(:valid_attributes) do
    {
      name: "João Silva",
      cpf: "46864663000",
      birth_date: "1980-01-01",
      street: "Rua das Flores",
      number: "123",
      neighborhood: "Centro",
      city: "São Paulo",
      state: "SP",
      zip_code: "01000-000",
      personal_phone: "11999999999",
      reference_phone: "11888888888",
      salary: 5000.0
    }
  end

  context "validations" do
    it "is valid with valid attributes" do
      proponent = Proponent.new(valid_attributes)
      expect(proponent).to be_valid
    end

    it "is not valid without a name" do
      proponent = Proponent.new(valid_attributes.merge(name: nil))
      expect(proponent).to_not be_valid
      expect(proponent.errors[:name]).to include("não pode ficar em branco")
    end

    it "is not valid without a cpf" do
      proponent = Proponent.new(valid_attributes.merge(cpf: nil))
      expect(proponent).to_not be_valid
      expect(proponent.errors[:cpf]).to include("não pode ficar em branco")
    end

    it "is not valid without a birth date" do
      proponent = Proponent.new(valid_attributes.merge(birth_date: nil))
      expect(proponent).to_not be_valid
      expect(proponent.errors[:birth_date]).to include("não pode ficar em branco")
    end

    it "is not valid without a street" do
      proponent = Proponent.new(valid_attributes.merge(street: nil))
      expect(proponent).to_not be_valid
      expect(proponent.errors[:street]).to include("não pode ficar em branco")
    end

    it "is not valid without a number" do
      proponent = Proponent.new(valid_attributes.merge(number: nil))
      expect(proponent).to_not be_valid
      expect(proponent.errors[:number]).to include("não pode ficar em branco")
    end

    it "is not valid without a neighborhood" do
      proponent = Proponent.new(valid_attributes.merge(neighborhood: nil))
      expect(proponent).to_not be_valid
      expect(proponent.errors[:neighborhood]).to include("não pode ficar em branco")
    end

    it "is not valid without a city" do
      proponent = Proponent.new(valid_attributes.merge(city: nil))
      expect(proponent).to_not be_valid
      expect(proponent.errors[:city]).to include("não pode ficar em branco")
    end

    it "is not valid without a state" do
      proponent = Proponent.new(valid_attributes.merge(state: nil))
      expect(proponent).to_not be_valid
      expect(proponent.errors[:state]).to include("não pode ficar em branco")
    end

    it "is not valid without a zip_code" do
      proponent = Proponent.new(valid_attributes.merge(zip_code: nil))
      expect(proponent).to_not be_valid
      expect(proponent.errors[:zip_code]).to include("não pode ficar em branco")
    end

    it "is not valid without a personal_phone" do
      proponent = Proponent.new(valid_attributes.merge(personal_phone: nil))
      expect(proponent).to_not be_valid
      expect(proponent.errors[:personal_phone]).to include("não pode ficar em branco")
    end

    it "is not valid without a salary" do
      proponent = Proponent.new(valid_attributes.merge(salary: nil))
      expect(proponent).to_not be_valid
      expect(proponent.errors[:salary]).to include("não pode ficar em branco")
    end

    it "is not valid with a salary above the maximum limit" do
      proponent = Proponent.new(valid_attributes.merge(salary: 7000.0))
      expect(proponent).to_not be_valid
      expect(proponent.errors[:salary]).to include("deve ser menor ou igual a 6101.06")
    end
  end

  context "CPF validation" do
    it "is not valid with an invalid CPF" do
      proponent = Proponent.new(valid_attributes.merge(cpf: "12345678900"))
      expect(proponent).to_not be_valid
      expect(proponent.errors[:cpf]).to include("não é válido")
    end

    it "is valid with a valid CPF" do
      proponent = Proponent.new(valid_attributes.merge(cpf: "46864663000"))
      expect(proponent).to be_valid
    end
  end
end
