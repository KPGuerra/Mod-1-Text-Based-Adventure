class Character < ActiveRecord::Base
    has_many :encounters
    has_many :items, through: :encounters
    has_many :enemies, through: :encounters
    belongs_to :user

    ## Make a method for character stats; Role, Atk, HP etc ?
    def self.character_stats
        puts @character.name
        puts @character.role
        puts @character.attack_power
        puts @character.hp
    end
end 