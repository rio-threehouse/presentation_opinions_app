class CreateChecks < ActiveRecord::Migration[5.0]
  def change
    create_table :checks do |t|
      t.references :comment, foreign_key: true
      t.references :user, foreign_key: true
      t.index [:comment_id, :user_id], unique: true

      t.timestamps
    end
  end
end
