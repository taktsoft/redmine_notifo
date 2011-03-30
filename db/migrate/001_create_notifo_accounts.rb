class CreateNotifoAccounts < ActiveRecord::Migration
  def self.up
    create_table :notifo_accounts do |t|
      t.string :username
      t.string :api_key
      t.boolean :active
      t.integer :user_id
    end
  end

  def self.down
    drop_table :notifo_accounts
  end
end
