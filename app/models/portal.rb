class Portal < ActiveRecord::Base
  validates :name, :presence => true
end
