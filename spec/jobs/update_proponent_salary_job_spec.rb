require 'rails_helper'

RSpec.describe UpdateProponentSalaryJob, type: :job do
  describe "#perform" do
    let(:proponent) { create(:proponent, salary: 3000.00) }

    it "updates the proponent's inss_discount and net_salary" do
      expect {
        UpdateProponentSalaryJob.perform_now(proponent.id)
        proponent.reload
      }.to change(proponent, :inss_discount).from(nil)
       .and change(proponent, :net_salary).from(nil)
    end

    it "logs an error when salary is invalid" do
      # Simulando um caso em que o salário é inválido (por exemplo, negativo)
      allow(Proponent).to receive(:find).and_raise(ArgumentError.new("Invalid salary"))

      expect(Rails.logger).to receive(:error).with(/Error updating proponent #{proponent.id}: Invalid salary/)

      expect {
        UpdateProponentSalaryJob.perform_now(proponent.id)
      }.not_to change { proponent.reload.inss_discount }
    end

    it "logs an error when salary is invalid" do
      # Simulando um caso em que o salário é inválido (por exemplo, negativo)
      allow(Proponent).to receive(:find).and_raise(ArgumentError.new("Invalid salary"))

      expect(Rails.logger).to receive(:error).with(/Error updating proponent #{proponent.id}: Invalid salary/)

      expect {
        UpdateProponentSalaryJob.perform_now(proponent.id)
      }.not_to change { proponent.reload.net_salary }
    end
  end
end
