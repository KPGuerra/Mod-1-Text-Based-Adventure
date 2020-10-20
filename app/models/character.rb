class Character < ActiveRecord::Base
    has_many :encounters
    has_many :items, through: :encounters
    has_many :enemies, through: :encounters
    belongs_to :user
end 