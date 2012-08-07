class AddUuidToModels < ActiveRecord::Migration
  def change
    add_column :magazines, :uuid, :string
    add_column :issues, :uuid, :string
    
    Magazine.all.each do |magazine|
      magazine.uuid = UUID.new.generate
      magazine.save
    end
    
    Issue.all.each do |issue|
      issue.uuid = UUID.new.generate
      issue.save
    end
  end    
end
