class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    t.string :name
    t.string :email
    t.string :oauth_user_id
    t.string :token
    t.string :secret
    end
  end
end
