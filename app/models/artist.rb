class Artist < ActiveRecord::Base
  has_many :paintings

  validates :name, presence: true
end