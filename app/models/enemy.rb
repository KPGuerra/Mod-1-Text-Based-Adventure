class Enemy < ActiveRecord::Base
    belongs_to :encounter
    @@prompt = TTY::Prompt.new

    
#ENEMY MOVES ==========================================================================================

# Give enemy array of moves. Randomize through them to get attack choices. Maybe the same for character ? Or maybe scripted moves
    @@enemy_attacks = ['Burst', 'Ignite', 'Grip', 'Punch', 'Backstab', 'Scratch']

# Give bosses different attacks ?
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
            puts "You dealt #{damage} damage!"
            puts "#{character.name} has #{character.hp} HP left!"
        end
    end
end
#========================================================================================================