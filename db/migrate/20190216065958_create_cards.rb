class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.references :user, foreign_key: true
      t.integer :manufacturer
      t.string :year
      t.string :player_first_name
      t.string :player_last_name
      t.string :series_number

      t.timestamps
    end
  end
end
