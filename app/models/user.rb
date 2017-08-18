class User < ActiveRecord::Base
  include Clearance::User
  mount_uploader :avatar, AvatarUploader
  validates :email, uniqueness: true
  has_many :authentications, :dependent => :destroy
  has_many :listings, dependent: :destroy
  has_many :reservations, dependent: :destroy

  def self.create_with_auth_and_hash(authentication, auth_hash)
    user = self.create!(
      email: auth_hash["extra"]["raw_info"]["email"],
      password: "qaqaqaqa"
    )
    user.authentications << authentication
    return user
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end
end