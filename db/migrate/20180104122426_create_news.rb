class CreateNews < ActiveRecord::Migration[5.1]
  def change
    create_table :news do |t|
      t.string :title
      t.text :body
      t.string :avatar
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
