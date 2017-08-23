class Listing < ApplicationRecord
	mount_uploaders :avatars, AvatarUploader
	belongs_to :user
	has_and_belongs_to_many :tags
	has_many :reservations, dependent: :destroy
	validates :price, presence: true
end
