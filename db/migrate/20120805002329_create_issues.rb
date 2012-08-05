class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.integer :magazine_id
      t.date :issue_date
      t.string :title

      t.timestamps
    end
  end
end
