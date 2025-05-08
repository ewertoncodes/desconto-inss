class AddNetSalaryAndInssDiscountToProponents < ActiveRecord::Migration[7.2]
  def change
    add_column :proponents, :net_salary, :decimal, precision: 10, scale: 2
    add_column :proponents, :inss_discount, :decimal, precision: 10, scale: 2
  end
end
