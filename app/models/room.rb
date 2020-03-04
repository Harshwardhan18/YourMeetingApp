class Room < ApplicationRecord
    has_many :meetings, :dependent => :delete_all
    has_many :users, through: :meetings
    validates :name, :capacity, presence: true

end
