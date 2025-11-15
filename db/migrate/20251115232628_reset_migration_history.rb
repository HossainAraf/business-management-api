# db/migrate/20251116000000_reset_migration_history.rb
class ResetMigrationHistory < ActiveRecord::Migration[8.1]
  def up
    # Clear all existing migration records
    execute "DELETE FROM schema_migrations"
    
    # Insert only the migrations that actually exist
    execute "INSERT INTO schema_migrations (version) VALUES ('20251115231758')" # Create business management tables
    execute "INSERT INTO schema_migrations (version) VALUES ('20251115232243')" # Drop old non prefixed tables
  end

  def down
    # This is irreversible by design
    raise ActiveRecord::IrreversibleMigration
  end
end