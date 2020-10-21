class Enemy < ActiveRecord::Base
    belongs_to :encounter
    @@prompt = TTY::Prompt.new
    # create_table "encounters", force: :cascade do |t|
    #     t.boolean "enemy"
    #     t.boolean "item"
    #     t.string "result"
    # end

    # create_table "characters", force: :cascade do |t|
    #     t.string "name"
    #     t.string "role"
    #     t.string "description"
    #     t.integer "hp"
    #     t.integer "level"
    #     t.integer "experience_points"
    #     t.integer "user_id"
    #     t.integer "attack_power"
    # end

    # create_table "enemies", force: :cascade do |t|
    #     t.string "name"
    #     t.string "role"
    #     t.string "description"
    #     t.integer "hp"
    #     t.integer "level"
    #     t.integer "attack_power"
    #     t.integer "encounter_id"
    # end

    # Give enemy array of moves. Randomize through them to get attack choices. Maybe the same for character ? Or maybe scripted moves
    @@enemy_attacks = ['Burst', 'Ignite', 'Grip', 'Punch', 'Backstab', 'Scratch']

    # Give bosses different attacks ?
    @@boss_attacks = ['Paralyze', 'Riptide', 'Haunt', 'Bloodlust', 'Tremblor', 'Poison']

    def enemy_moves
        moves = @@enemy_attacks.sample(4)
        moves
        # @@prompt.select("Choose your attack:", [moves[0], moves[1], moves[2], moves[3]])
    end

    def boss_moves
        moves = @@boss_attacks
        moves
        # @@prompt.select('Choose your attack:', [moves[0], moves[1], moves[2], moves[3]])
    end


    # Then we add in combat (randomize attks(.sample method))
    # Will be moved to respective classes (Character, Enemy)
    #------------------------------------------#
    def self.attack(character) #place holder method name
        damage = character.attack_power
        if damage > 0
            self.update(hp: self.hp - damage)
            puts "You dealt #{dmg} damage!"
            puts "#{self.name} has #{self.hp} HP left!"
        end
    end
    #------------------------------------------#
end 