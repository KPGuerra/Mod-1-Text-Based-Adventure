class Character < ActiveRecord::Base
    has_many :encounters
    has_many :items, through: :encounters
    has_many :enemies, through: :encounters
    belongs_to :user

#Display Stats =====================================================================================
#Center these later
    def display_character_stats
        system('clear')
        puts "------------------"
        puts "Name: #{self.name}"
        puts "Role: #{self.role}"
        puts "Level: #{self.level}"
        puts "XP: #{self.experience_points}\n\n"
        puts "Attack: #{self.attack_power}"
        puts "HP: #{self.hp}"
        puts "------------------"
    end
#====================================================================================================
    
#Inventory Methods ==================================================================================
    def display_inventory
        system('clear')
        inventory = self.items
        if inventory.count == 0
            puts "Your inventory is empty."
        else 
            inventory.each do |item|
                puts "#{item.name}: #{item.description}"
            end
        end
    end 

    def add_item_to_inventory(name, description, item_type, encounter)
        item = Item.create(name: name, description: description, item_type: item_type, encounter_id: encounter.id)
        puts "-----------------------------------------------------------------"
        puts "|You have picked up #{item.name} and it has been added to your inventory.|"
        puts "-----------------------------------------------------------------"
    end 

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
        new_encounter = Encounter.create(enemy: false, item: true, character_id: self.id) # Do we even need this here
        # @@items.sample(1)
    end

    def encounter_enemy
        # Needs workkkk
        new_battle_encounter = Encounter.create(enemy: true, item: false, character_id: self.id)
    end
end 
#================================================================================================