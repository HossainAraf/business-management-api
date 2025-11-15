class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  # add prefix to all tables. bm=business management
  self.table_name_prefix = 'bm_'
end
