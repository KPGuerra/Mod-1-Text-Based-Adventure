class Enemy < ActiveRecord::Base
    belongs_to :encounter
    @@prompt = TTY::Prompt.new
    @@pastel = Pastel.new
    
#ENEMY MOVES ==========================================================================================
    @@enemy_attacks = ['Burst', 'Ignite', 'Grip', 'Punch', 'Backstab', 'Scratch']
    def enemy_moves
        moves = @@enemy_attacks.sample(4)
        moves
    end
    
    @@boss_attacks = ['Paralyze', 'Riptide', 'Haunt', 'Bloodlust', 'Tremblor', 'Poison']
    def boss_moves
        moves = @@boss_attacks.sample(4)
        moves
    end
#========================================================================================================

#Attacking character ====================================================================================
    def attk_char(character)
        damage = self.attack_power
        if damage > 0
            character.update(hp: character.hp - damage)
            puts @@pastel.magenta("-----------------------------------------------------------------".center(145))
            puts @@pastel.magenta("#{self.name} dealt #{damage} damage to #{character.name}!".center(145))
            puts @@pastel.magenta("#{character.name} has #{character.hp} HP left!".center(145))
            puts @@pastel.magenta("-----------------------------------------------------------------".center(145))
            sleep(1)
        end
    end
end
#========================================================================================================