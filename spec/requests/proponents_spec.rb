# spec/requests/proponents_spec.rb
require 'rails_helper'

RSpec.describe "Proponents", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET /proponents" do
    it "renders a successful response" do
      get proponents_path
      expect(response).to be_successful
    end
  end

  describe "GET /proponents/:id" do
    it "renders a successful response" do
      proponent = create(:proponent) # Usando a factory :proponent
      get proponent_path(proponent)
      expect(response).to be_successful
    end
  end

  describe "GET /proponents/new" do
    it "renders a successful response" do
      get new_proponent_path
      expect(response).to be_successful
    end
  end

  describe "POST /proponents" do
    context "with valid parameters" do
      it "creates a new proponent" do
        expect {
          post proponents_path, params: { proponent: attributes_for(:proponent) }
        }.to change(Proponent, :count).by(1)
      end

      it "redirects to the created proponent" do
        post proponents_path, params: { proponent: attributes_for(:proponent) }
        expect(response).to redirect_to(proponent_path(Proponent.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new proponent" do
        expect {
          post proponents_path, params: { proponent: attributes_for(:proponent, name: "") }
        }.to_not change(Proponent, :count)
      end

      it "renders a 'new' template" do
        post proponents_path, params: { proponent: attributes_for(:proponent, name: "") }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /proponents/:id" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: "Updated Name" }
      }

      it "updates the requested proponent" do
        proponent = create(:proponent) # Usando a factory :proponent
        patch proponent_path(proponent), params: { proponent: new_attributes }
        proponent.reload
        expect(proponent.name).to eq("Updated Name")
      end

      it "redirects to the proponent" do
        proponent = create(:proponent) # Usando a factory :proponent
        patch proponent_path(proponent), params: { proponent: new_attributes }
        proponent.reload
        expect(response).to redirect_to(proponent_path(proponent))
      end
    end

    context "with invalid parameters" do
      it "renders a 'edit' template" do
        proponent = create(:proponent) # Usando a factory :proponent
        patch proponent_path(proponent), params: { proponent: { name: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /proponents/:id" do
    it "destroys the requested proponent" do
      proponent = create(:proponent) # Usando a factory :proponent
      expect {
        delete proponent_path(proponent)
      }.to change(Proponent, :count).by(-1)
    end

    it "redirects to the proponents list" do
      proponent = create(:proponent) # Usando a factory :proponent
      delete proponent_path(proponent)
      expect(response).to redirect_to(proponents_path)
    end
  end
end
