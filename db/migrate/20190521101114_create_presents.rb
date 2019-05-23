class CreatePresents < ActiveRecord::Migration[5.0]
  def change
    create_table :presents do |t|
      t.string :title
      t.string :name_read
      t.string :research
      t.references :user, foreign_key: true
      t.references :main, foreign_key: true

      t.timestamps
    end
  end
end
