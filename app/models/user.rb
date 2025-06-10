class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :job_category
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower
  
  attachment :profile_image

  # フォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # フォローを解除する
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end

  validates :name, presence: true, length: { maximum: 20 }
  validates :user_name, presence: true, length: { maximum: 20 }
  validates :organization_name, presence: true, length: { maximum: 20 }
  validates :job_category_id, presence: true
end
