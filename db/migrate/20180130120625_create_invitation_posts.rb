class CreateInvitationPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :invitation_posts do |t|
      t.string :name
      t.string :info
      t.belongs_to :sport, foreign_key: true
      t.datetime :date
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
