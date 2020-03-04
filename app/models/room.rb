class Room < ApplicationRecord
    has_many :meetings
    has_many :users, through: :meetings
    validates :name, :capacity, presence: true
end
