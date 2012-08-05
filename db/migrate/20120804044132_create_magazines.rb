class CreateMagazines < ActiveRecord::Migration
  def change
    create_table :magazines do |t|
      t.string :name
      t.text :description
      t.date :publication_date

      t.timestamps
    end
  end
end
