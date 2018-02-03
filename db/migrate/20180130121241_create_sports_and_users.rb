class CreateSportsAndUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :sports_users, id: false do |t|
      t.integer :sport_id
      t.integer :user_id
    end
  end
end
