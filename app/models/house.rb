class House < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  mount_uploader :image, ImageUploader
  validates_presence_of :name, :description, :price
end
