class Room < ApplicationRecord
    has_many :entries, dependent: :destroy
    has_many :users, through: :entries
    has_many :messages, dependent: :destroy
end
