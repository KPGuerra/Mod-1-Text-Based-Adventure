class Encounter < ActiveRecord::Base
    has_many :items
    has_many :enemies
    belongs_to :character

    @@items = ['Broadsword', 'Health Potion', 'Speed Boost', 'Attack Elixir'] # Add more once all is working good.

    def self.new_boss
        Enemy.create(name: "", role: "", description: "", hp: 220, level: 10, attack_power: 20, encounter_id: self.id, boss: true)
    end

    def battle_over?(character, enemy)
        if (enemy.hp <= 0) || (character.hp <= 0)
            true
        end 
    end 

    def winner_or_not_winner(character, enemy)
        if enemy.hp <= 0
            self.update(result: "win")
            puts "You have defeated #{enemy.name}"
            sleep(1)
        elsif character.hp <= 0 
            system("clear")
            self.update(result: "lost")
            puts "You have been defeated. GG noob."
            sleep(1)
            CLI.user_menu
        end
    end
    
    def combat(character, enemy)
        system('clear')
        until battle_over?(character, enemy) == true
            puts "\n"
            character.attk_enemy(enemy)
            puts "\n\n"
            sleep(1)
            enemy.attk_char(character)
        end 
        self.winner_or_not_winner(character, enemy)
    end
end 
