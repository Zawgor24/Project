class CreateSports < ActiveRecord::Migration[5.1]
  def change
    create_table :sports do |t|
      t.string :name
      t.string :info
      t.string :avatar

      t.timestamps
    end
  end
end
