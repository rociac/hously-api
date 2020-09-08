class User < ApplicationRecord
  has_secure_password
  has_many :houses, dependent: :destroy
  mount_uploader :avatar, AvatarUploader
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
