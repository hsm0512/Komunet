class Post < ApplicationRecord
    belongs_to :user
    belongs_to :job_category, optional: true
    belongs_to :style, optional: true
    attachment :image
    has_many :comments, dependent: :destroy
    has_many :favorites, dependent: :destroy

    validates :title, presence: true, length: { maximum: 50 }, on: :publish
    validates :content, presence: true, length: { maximum: 200 }, on: :publish
    validates :job_category_id, presence: true, on: :publish
    validates :style_id, presence: true, on: :publish

    enum status: { draft: 1, published: 0 }

    def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end
end
