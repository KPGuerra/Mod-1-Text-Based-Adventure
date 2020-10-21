class Encounter < ActiveRecord::Base
    has_many :items
    has_many :enemies
    belongs_to :character

    # Item Encounters -------------------------------------------------
    def self.ecounter_item_weapon
        # Needs workkkk
        Encounter.create(enemy: false, item: true)
    end
    def self.ecounter_item_random
        # Incomplete
        Encounter.create(enemy: false, item: true)
    end

    # Enemy Encounter -------------------------------------------------
    def self.encounter_enemy
        Encounter.create(enemy: true, item: false)
    end

    # Create enemy
    def self.new_enemy
        Enemy.create(name: "", role: "", description: "", hp: 100, level: 2, attack_power: 8, encounter_id: self.id, boss: false)
    end

    # Make a boss column in Enemy table

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