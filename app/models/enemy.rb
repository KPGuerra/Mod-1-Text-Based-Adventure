class Enemy < ActiveRecord::Base
    belongs_to :encounter
    @@prompt = TTY::Prompt.new

    
#ENEMY MOVES ==========================================================================================
    @@enemy_attacks = ['Burst', 'Ignite', 'Grip', 'Punch', 'Backstab', 'Scratch']

    @@boss_attacks = ['Paralyze', 'Riptide', 'Haunt', 'Bloodlust', 'Tremblor', 'Poison']

    def enemy_moves
        moves = @@enemy_attacks.sample(4)
        moves
    end

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
            puts "-----------------------------------------------------------------".center(145)
            puts "#{self.name} dealt #{damage} damage to #{character.name}!".center(145)
            puts "#{character.name} has #{character.hp} HP left!".center(145)
            puts "-----------------------------------------------------------------".center(145)
            sleep(1)
        end
    end
end
#========================================================================================================