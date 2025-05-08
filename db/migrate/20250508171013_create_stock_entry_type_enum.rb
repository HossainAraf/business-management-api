class CreateStockEntryTypeEnum < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE TYPE stock_entry_type AS ENUM ('purchase', 'adjustment', 'return');
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE stock_entry_type;
    SQL
  end
end
