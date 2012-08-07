class Magazine < ActiveRecord::Base
  has_many :issues, :dependent => :destroy
  belongs_to :user
end
