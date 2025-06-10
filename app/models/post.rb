class Post < ApplicationRecord
    belongs_to :user
    belongs_to :job_category
    belongs_to :style
    attachment :image
    has_many :comments, dependent: :destroy
end
