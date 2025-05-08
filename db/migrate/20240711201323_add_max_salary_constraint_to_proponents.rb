class AddMaxSalaryConstraintToProponents < ActiveRecord::Migration[7.2]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE proponents
          ADD CONSTRAINT check_max_salary CHECK (salary <= 6101.06);
        SQL
      end

      dir.down do
        execute <<-SQL
          ALTER TABLE proponents
          DROP CONSTRAINT IF EXISTS check_max_salary;
        SQL
      end
    end
  end
end
