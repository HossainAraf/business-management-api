class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  # add prefix to all tables
  self.table_name_prefix = 'app_'
end
