class CreateMains < ActiveRecord::Migration[5.0]
  def change
    create_table :mains do |t|
      t.string :title
      t.date :date
      t.string :time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
