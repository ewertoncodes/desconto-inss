
class UpdateProponentSalaryJob < ApplicationJob
  queue_as :default

  def perform(proponent_id)
    proponent = Proponent.find(proponent_id)
    result = InssCalculationService.new(proponent.salary).call

    proponent.update!(inss_discount: result[:discount], net_salary: result[:net_salary])
  rescue ArgumentError => e
    Rails.logger.error("Error updating proponent #{proponent_id}: #{e.message}")
  end
end
