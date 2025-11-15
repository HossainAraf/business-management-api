# frozen_string_literal: true

class CreateAdjustmentTypeEnum < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE TYPE adjustment_type_enum AS ENUM ('add', 'remove');
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE adjustment_type_enum;
    SQL
  end
end
