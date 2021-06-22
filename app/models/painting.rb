class Painting < ActiveRecord::Base
  belongs_to :artist
  validates :title, :image, presence: true
  validates :slug, uniqueness: true
end