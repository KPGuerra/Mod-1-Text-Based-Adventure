class Encounter < ActiveRecord::Base
    has_many :items
    has_many :enemies
    belongs_to :character

    # create_table "encounters", force: :cascade do |t|
    #     t.boolean "enemy"
    #     t.boolean "item"
    #     t.string "result"
    # end

    # create_table "items", force: :cascade do |t|
    #     t.string "name"
    #     t.string "description"
    #     t.string "item_type"
    #     t.integer "encounter_id"
    # end

    # Item Encounters
    def ecounter_item_weapon
        Encounter.create(enemy: false, item: true)
    end
    def ecounter_item_random
        Encounter.create(enemy: false, item: true)
    end

    # Enemy Encounter
    def encounter_enemy
        Encounter.create(enemy: true, item: false)
    end

    # create_table "enemies", force: :cascade do |t|
    #     t.string "name"
    #     t.string "role"
    #     t.string "description"
    #     t.integer "hp"
    #     t.integer "level"
    #     t.integer "attack_power"
    #     t.integer "encounter_id"
    # end

    # Create enemy
    def new_enemy
        Enemy.create(name: "", role: "", description: "", hp: "", level: "", attack_power: "", encounter_id: "")
    end

    def new_boss
        
    end

    def winner_or_not_winner(character, enemy)
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