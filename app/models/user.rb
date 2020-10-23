class User < ActiveRecord::Base
    has_many :characters
    has_many :encounters, through: :characters
    has_many :items, through: :encounters
    has_many :enemies, through: :encounters

#HELPER METHODS ========================================================================
    def has_characters?
        if self.characters.count == 0
            puts "You don't have any characters :("
            sleep(2)
            CLI.user_menu
        else
            CLI.select_save
        end
    end 

    def has_specific_character?(name)
        self.characters.exists?(name: name)
    end 
end 