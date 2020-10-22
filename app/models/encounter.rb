class Encounter < ActiveRecord::Base
    has_many :items
    has_many :enemies
    belongs_to :character

    @@items = ['Broadsword', 'Health Potion', 'Speed Boost', 'Attack Elixir'] # Add more once all is working good.

    def self.new_boss
        Enemy.create(name: "", role: "", description: "", hp: 220, level: 10, attack_power: 20, encounter_id: self.id, boss: true)
    end

    def self.winner_or_not_winner(character, enemy)
        if enemy.hp <= 0
            Encounter.update(result: "win")
            puts "You have defeated #{enemy.name}"
        elsif character.hp <= 0 
            system("clear")
            puts "You have been defeated. GG noob."
            CLI.user_menu
        end
    end
end 