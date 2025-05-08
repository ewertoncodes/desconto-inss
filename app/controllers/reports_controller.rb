class ReportsController < ApplicationController
  def employees_report
    @salary_ranges = Proponent.grouped_by_salary_range
  end
end
