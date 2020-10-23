class Character < ActiveRecord::Base
    has_many :encounters
    has_many :items, through: :encounters
    has_many :enemies, through: :encounters
    belongs_to :user
    @@pastel = Pastel.new

#Location ==========================================================================================
    def where_am_i
        if self.location == "Intro"
            CLI.story_introduction
        elsif self.location == "Out of Cell"
            CLI.story_out_of_cell
        elsif self.location == "Hallway"
            CLI.story_continue_hallway
        elsif self.location == "Keypad"
            CLI.story_key_pad_door
        elsif self.location == "Boss"
            CLI.story_boss_room
        end
    end

#Display Stats =====================================================================================
#Center these later
    def display_character_stats
        system('clear')
        puts "------------------".center(145)
        puts "Name: #{self.name}".center(145)
        puts "Role: #{self.role}".center(145)
        puts "Level: #{self.level}".center(145)
        puts "Attack: #{self.attack_power}".center(145)
        puts "HP: #{self.hp}".center(145)
        puts "------------------".center(145)
    end
#====================================================================================================
    
#Inventory Methods ==================================================================================
    def display_inventory
        system('clear')
        inventory = self.items
        if inventory.count == 0
            puts "Your inventory is empty."
        else 
            inventory.reload.map do |item|
                puts "#{item.name}: #{item.description}"
            end
        end
    end 

    def add_item_to_inventory(add_item, encounter)
        add_item.update(encounter_id: encounter.id)
        puts @@pastel.magenta("-----------------------------------------------------------------".center(145))
        puts @@pastel.magenta("|You have picked up #{add_item.name} and it has been added to your inventory.|".center(145))
        puts @@pastel.magenta("-----------------------------------------------------------------".center(145))
    end 
#Still have to test
    def use_item(item_name)
        item = self.items.find_by(name: item_name)
        if item.item_type == "Healing Potion"
            if self.hp += 10 < self.base_hp
                puts "You drank the entire bottle. You feel energized! (+10 HP)"
                puts "You HP is now #{self.hp}"
                #removes Item from inventory 
                Item.destroy(item)
            else
                #if HP goes ove the base_health, it automatically caps at base_hp aka your max hp
                self.hp = self.base_hp
                puts "You drank the entire bottle. You are at full health!"
                puts "Your HP is now #{self.base_hp}"
                Item.destroy(item)
            end 
        elsif item.item_type == "Weapon"
            #weapons will boost the characters attack points by a random number?
            if self.current_weapon == nil 
                random_attack_boost = [2,3,5].sample
                self.attack_power += random_attk_boost
                puts "You've equipped #{item.name}. (+#{random_attk_boost})"
            else 
                equipped_weapon = self.items.find_by(current_weapon)
                Item.destroy(equppied_weapon)
                self.attack_power = self.base_attk
                random_attack_boost = [5,6,10].sample
                self.attack_power += random_attack_boost
                puts "You have replaced your weapon with #{item.name}. (+#{random_attk_boost})"
            end 
        else 
            puts "You can't use/equip this!"
        end 
    end 
#================================================================================================

#ENCOUNTER ======================================================================================
    def encounter_item_random
        # Incomplete
        # Create an array of hash for items ? - Might be a much simpler way
        new_encounter = Encounter.find_or_create_by(enemy: false, item: true, character_id: self.id) # Do we even need this here
        # @@items.sample(1)
    end

    def encounter_enemy
        new_battle_encounter = Encounter.create(enemy: true, item: false, character_id: self.id)
    end 
#================================================================================================

#Attack enemy =======================================================================================
    def attk_enemy(enemy)
        damage = self.attack_power
        if damage > 0
            enemy.update(hp: enemy.hp - damage)
            puts @@pastel.green("-----------------------------------------------------------------".center(145))
            puts @@pastel.green("You dealt #{damage} damage to #{enemy.name}!".center(145))
            puts @@pastel.green("#{enemy.name} has #{enemy.hp} HP left!".center(145))
            puts @@pastel.green("-----------------------------------------------------------------".center(145))
            sleep(1)
        end
    end 

end
#========================================================================================================