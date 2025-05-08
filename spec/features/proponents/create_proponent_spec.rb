# spec/features/proponents/create_proponent_spec.rb
require 'rails_helper'

RSpec.describe 'CreateProponent', type: :feature, js: true do
  let(:user) { create(:user) }

  let(:valid_attributes) do
    {
      name: 'João Silva',
      cpf: '46864663000',
      birth_date: '1980-01-01',
      street: 'Rua das Flores',
      number: '123',
      neighborhood: 'Centro',
      city: 'São Paulo',
      state: 'SP',
      zip_code: '01001-000',
      personal_phone: '11987654321',
      reference_phone: '1122334455',
      salary: '5000.00'
    }
  end

  let(:invalid_attributes) do
    {
      name: '',
      cpf: '',
      birth_date: '',
      street: '',
      number: '',
      neighborhood: '',
      city: '',
      state: '',
      zip_code: '',
      personal_phone: '',
      reference_phone: '',
      salary: ''
    }
  end

  before do
    login_as(user, scope: :user)
  end

  describe 'Happy path: creates a proponent successfully' do
    it 'creates a proponent successfully' do
      visit new_proponent_path

      fill_in 'name', with: valid_attributes[:name]
      fill_in 'cpf', with: valid_attributes[:cpf]
      fill_in 'birth_date', with: valid_attributes[:birth_date]
      fill_in 'street', with: valid_attributes[:street]
      fill_in 'number', with: valid_attributes[:number]
      fill_in 'neighborhood', with: valid_attributes[:neighborhood]
      fill_in 'city', with: valid_attributes[:city]
      fill_in 'state', with: valid_attributes[:state]
      fill_in 'zip_code', with: valid_attributes[:zip_code]
      fill_in 'personal_phone', with: valid_attributes[:personal_phone]
      fill_in 'reference_phone', with: valid_attributes[:reference_phone]
      fill_in 'salary', with: valid_attributes[:salary]

      click_button 'Salvar'

      expect(page).to have_content 'Proponente foi criado com sucesso'
    end
  end

  describe 'Unhappy path: shows errors when trying to create a proponent with invalid attributes' do
    it 'shows errors when trying to create a proponent with invalid attributes' do
      visit new_proponent_path

      fill_in 'name', with: invalid_attributes[:name]
      fill_in 'cpf', with: invalid_attributes[:cpf]
      fill_in 'birth_date', with: invalid_attributes[:birth_date]
      fill_in 'street', with: invalid_attributes[:street]
      fill_in 'number', with: invalid_attributes[:number]
      fill_in 'neighborhood', with: invalid_attributes[:neighborhood]
      fill_in 'city', with: invalid_attributes[:city]
      fill_in 'state', with: invalid_attributes[:state]
      fill_in 'zip_code', with: invalid_attributes[:zip_code]
      fill_in 'personal_phone', with: invalid_attributes[:personal_phone]
      fill_in 'reference_phone', with: invalid_attributes[:reference_phone]
      fill_in 'salary', with: invalid_attributes[:salary]

      click_button 'Salvar'

      expect(page).to have_content 'não pode ficar em branco'
    end
  end
end
