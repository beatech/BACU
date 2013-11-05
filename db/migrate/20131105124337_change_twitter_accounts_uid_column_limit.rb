class ChangeTwitterAccountsUidColumnLimit < ActiveRecord::Migration
  def self.up
    change_column :twitter_accounts, :uid, :integer, limit: 8
  end

  def self.down
    change_column :twitter_accounts, :uid, :integer
  end
end
