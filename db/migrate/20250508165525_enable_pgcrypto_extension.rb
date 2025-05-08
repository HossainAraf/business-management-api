class EnablePgcryptoExtension < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'pgcrypto' # required for gen_random_uuid()
  end
end
