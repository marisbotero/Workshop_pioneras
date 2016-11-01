class CreateAdvances < ActiveRecord::Migration
  def change
    create_table :advances do |t|
      t.references :profile, index: true, foreign_key: true
      t.references :skill, index: true, foreign_key: true
      t.integer :percentage
      t.text :description

      t.timestamps null: false
    end
  end
end
