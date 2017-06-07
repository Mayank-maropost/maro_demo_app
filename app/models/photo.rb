class Photo < ApplicationRecord
  belongs_to :user
  mount_uploader :image_url, ImageUploader

  validates :name, presence: true
  validates :name, :uniqueness => true
end
