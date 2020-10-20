class Encounter < ActiveRecord::Base
    has_many :items
    has_many :enemies
    belongs_to :character
end 