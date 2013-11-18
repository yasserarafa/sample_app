class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable , :omniauthable 
  include Authentication::ActiveRecordHelpers

  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid



  has_many :microposts, dependent: :destroy
  has_many :articles
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

	
end