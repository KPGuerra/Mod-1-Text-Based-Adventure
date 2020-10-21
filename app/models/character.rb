class Character < ActiveRecord::Base
    has_many :encounters
    has_many :items, through: :encounters
    has_many :enemies, through: :encounters
    belongs_to :user

#Display Stats----------------------------------------------
#Center these later
    def self.display_character_stats
        puts "------------------"
        puts "Name: #{self.name}"
        puts "Role: #{self.role}"
        puts "Level: #{self.level}"
        puts "XP: #{self.experience_points}\n\n"
        puts "Attack: #{self.attack_power}"
        puts "HP: #{self.hp}"
        puts "------------------"
    end
    
#Inventory Methods---------------------------------------
    def display_inventory
        inventory = self.items
        if inventory.count == 0
            puts "Your inventory is empty."
        else 
            inventory.each do |item|
                puts "#{item.name}: #{item.descripton}"
            end
        end
    end 

    def add_item_to_inventory(name, descripton, item_type)
        Item.create(name: name, descripton: descripton, item_type: item_type, character_id: self.id)
    end 

    def use_item(item_name)
        item = self.items.find_by(name: item_name)
        if item.item_type == "Healing Potion"
            self.hp += 10
            #removes Item from inventory 
            Item.destroy(item)
        elsif item.item_type == "Weapon"
            #weapons will boost the characters attack points by a random number?
            self.attack_power += [2,3,5].sample
        end 
    end 
#--------------------------------------------------------

end 