require 'rails_helper'

RSpec.describe InssCalculationService do
  describe '#call' do
    context 'with salary in the first bracket' do
      it 'correctly calculates for R$ 1,000.00' do
        service = InssCalculationService.new(1000.00)
        result = service.call

        expect(result[:discount]).to eq(75.00)
        expect(result[:net_salary]).to eq(925.00)
      end

      it 'correctly calculates for R$ 1,045.00 (bracket limit)' do
        service = InssCalculationService.new(1045.00)
        result = service.call

        expect(result[:discount]).to eq(78.38)
        expect(result[:net_salary]).to eq(966.62)
      end
    end

    context 'with salary in the second bracket' do
      it 'correctly calculates for R$ 1,500.00' do
        service = InssCalculationService.new(1500.00)
        result = service.call

        expect(result[:discount]).to eq(119.33)
        expect(result[:net_salary]).to eq(1380.67)
      end

      it 'correctly calculates for R$ 2,089.60 (bracket limit)' do
        service = InssCalculationService.new(2089.60)
        result = service.call

        expect(result[:discount]).to eq(172.39)
        expect(result[:net_salary]).to eq(1917.21)
      end
    end

    context 'with salary in the third bracket' do
      it 'correctly calculates for R$ 3,000.00' do
        service = InssCalculationService.new(3000.00)
        result = service.call

        expect(result[:discount]).to eq(281.64)
        expect(result[:net_salary]).to eq(2718.36)
      end

      it 'correctly calculates for R$ 3,134.40 (bracket limit)' do
        service = InssCalculationService.new(3134.40)
        result = service.call

        expect(result[:discount]).to eq(297.77)
        expect(result[:net_salary]).to eq(2836.63)
      end
    end

    context 'with salary in the fourth bracket' do
      it 'correctly calculates for R$ 5,000.00' do
        service = InssCalculationService.new(5000.00)
        result = service.call

        expect(result[:discount]).to eq(558.95)
        expect(result[:net_salary]).to eq(4441.05)
      end

      it 'correctly calculates for R$ 6,101.06 (maximum limit)' do
        service = InssCalculationService.new(6101.06)
        result = service.call

        expect(result[:discount]).to eq(713.10)
        expect(result[:net_salary]).to eq(5387.96)
      end
    end

    context 'with invalid salary' do
      it 'rejects salary above maximum limit' do
        expect {
          InssCalculationService.new(6101.07).call
        }.to raise_error(ArgumentError, "Gross salary cannot be greater than 6101.06")
      end

      it 'rejects negative salary' do
        expect {
          InssCalculationService.new(-100.00).call
        }.to raise_error(ArgumentError, "Gross salary must be positive")
      end
    end
  end
end
