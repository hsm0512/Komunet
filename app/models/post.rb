class Post < ApplicationRecord
    belongs_to :user
    belongs_to :job_category
    belongs_to :style
    attachment :image
    has_many :comments, dependent: :destroy
    has_many :favorites, dependent: :destroy

    validates :title, presence: true, length: { maximum: 50 }
    validates :content, presence: true, length: { maximum: 200 }
    validates :job_category_id, presence: true
    validates :style_id, presence: true 

    def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end
end
