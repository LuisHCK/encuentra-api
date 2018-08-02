class AddSocialIdsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :fb_uid, :string, unique: true
    add_column :users, :gl_uid, :string, unique: true
    add_column :users, :tw_uid, :string, unique: true
  end
end
