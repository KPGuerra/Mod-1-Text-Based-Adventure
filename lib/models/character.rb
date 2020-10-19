class Character < ActiveRecord::Base
    has_many :battles
    has_many :items
    has_many :enemies, through: :battles
    belongs_to :user_id
end 