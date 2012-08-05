class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :issue_id
      t.integer :page_number
      t.text :content

      t.timestamps
    end
  end
end
