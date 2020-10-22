require 'pry'
class CLI 
    @@prompt = TTY::Prompt.new
    @@pastel = Pastel.new
    @@font = TTY::Font.new(:doom)

    def self.title
        system('clear')
        sleep(1)
        puts @@pastel.red.bold(@@font.write("ROGUEE!".center(25), letter_spacing: 4))
    end

    def self.main_menu
        sleep(1)
        user_choice = @@prompt.select("", ["Log In", "Create Account", "Leaderboards", "Exit"])
        if user_choice == "Log In"
            self.log_in
        elsif
            user_choice == "Create Account"
            self.create_account
        elsif
            user_choice == "Leaderboards"
            self.leaderboards
        elsif
            user_choice == "Exit"
            system('clear')
            exit
        end
    end

    def self.log_in
        user_name = @@prompt.ask("Username:")
        password = @@prompt.mask("Password:")
        if User.find_by(user_name: user_name, password: password)
            @current_user = User.find_by(user_name: user_name, password: password)
            system('clear')
            self.user_menu
        else #user does not exist
            system("clear")
            choice = @@prompt.select("Username/Password is incorrect",["Retry", "Create A New Account"])
            if choice == "Retry"
                system("clear")
                self.log_in
            elsif choice == "Create A New Account"
                system("clear")
                self.create_account
            end    
        end
    end

    def self.create_account
        user_name = @@prompt.ask("Username:")
        password = @@prompt.mask("Password:")
        @current_user = User.create(user_name: user_name, password: password)
        system("clear")
        self.user_menu
    end 


    # After user logs in, bring up another menu/options. Ex: Start Game, Instructions/How-to-play, Exit
    def self.user_menu
        system("clear")
        # puts "Welcome #{user_name}"
        choice = @@prompt.select("Welcome #{@current_user.user_name}\n\n", ["Start", "How-to-play", "Update Account", "Exit"])
        #Start
        if choice == "Start"
            self.start_game
        #How-to-play - #back
        elsif choice == "How-to-play"
            self.how_to_play
        # Update account
        elsif choice == "Update Account"
            self.account_update
        #Exit
        else
            exit
        end
    end

    # Able to change user_name & pw/ delete account
    def self.account_update
        choice = @@prompt.select("") do |menu|
            menu.choice "Update account name", 1
            menu.choice "Update password", 2
            menu.choice "Delete account", 3
            menu.choice "Back", 4
        end

        case choice
        when 1 # Needs work
            new_name = @@prompt.ask("Input new user name:")
            @current_user.user_name.update(user_name: new_name)
            puts "Your username has been succesfully updated"
            self.user_menu
        when 2 # Needs work
            current_user = User.find_by(user_name: user_name, password: password)
            new_password = @@prompt.ask("Input new password:")
            current_user.update(password: new_password)
            puts "Your password has been successfully updated"
            self.user_menu
        when 3 # WORKSS
            are_you_sure = @@prompt.select("Are you sure?", ["Yes", "No"])
            if are_you_sure == "Yes"
                @current_user.destroy
                sleep(1.5)
                puts "Your account has been successfully destroyed"
                self.main_menu
            elsif are_you_sure == "No"
                self.account_update
            end
        when 4
            self.user_menu
        end
    end

    def self.start_game
        # Characters to choose from:
        # Grimsborth, Kinklesburg, Croesus, Luminol
        # Role -> Huntress, Mercenary, Mage, Warrior

        # "Choose Your Character, give an option like the menus, display base stats of that character, able to go back if they don't want that specific character"
        char = @@prompt.select("Choose your character:") do |menu|
            menu.choice "Grimsborth", 1
            menu.choice "Kinklesburg", 2
            menu.choice "Croseus", 3
            menu.choice "Luminol", 4
            menu.choice "Exit", 5
        end
        
        case char
        when 1
            sleep(1)
            puts "----------------"
            puts "Name: Grimsborth"
            puts "Role:    Warrior"
            puts "----------------"
            puts "HP:          150"
            puts "Attack:       10"
            puts "----------------"
            question = @@prompt.select("Are you sure?", ["Yes", "No"])
            if question == "No"
                sYesstem('clear')
                self.start_game
            elsif question == "Yes"
                #procede to the actual game
                @character = Character.find_or_create_by(name: "Grimsborth", role: "Warrior", description: "", hp: 150, level: 1, experience_points: 0, user_id: @current_user.id, attack_power: 10, current_weapon: nil, base_hp: 150,  base_attk: 10 )
            end
        when 2
            sleep(1)
            puts "----------------"
            puts "Name: Kinklesburg"
            puts "Role:   Mercenary"
            puts "----------------"
            puts "HP:          100"
            puts "Attack:        7"
            puts "----------------"
            question = @@prompt.select("Are you sure?", ["Yes", "No"])
            if question == "No"
                system('clear')
                self.start_game
            elsif question == "Yes"
                #procede to the actual game
                @character = Character.find_or_create_by(name: "Kinklesburg", role: "Mercenary", description: "", hp: 100, level: 1, experience_points: 0, user_id: @current_user.id, attack_power: 7, current_weapon: nil, base_hp: 100,  base_attk: 7)
            end
        when 3
            sleep(1)
            puts "----------------"
            puts "Name:     Croseus"
            puts "Role:    Huntress"
            puts "----------------"
            puts "HP:          110"
            puts "Attack:        5"
            puts "----------------"
            question = @@prompt.select("Are you sure?", ["Yes", "No"])
            if question == "No"
                system('clear')
                self.start_game
            elsif question == "Yes"
                #procede to the actual game
                @character = Character.find_or_create_by(name: "Croseus", role: "Huntress", description: "", hp: 110, level: 1, experience_points: 0, user_id: @current_user.id, attack_power: 5, current_weapon: nil, base_hp: 110,  base_attk: 5)
            end
        when 4
            sleep(1)
            puts "----------------"
            puts "Name:    Luminol"
            puts "Role:       Mage"
            puts "----------------"
            puts "HP:           90"
            puts "Attack:        9"
            puts "----------------"
            question = @@prompt.select("Are you sure?", ["Yes", "No"])
            if question == "No"
                system('clear')
                self.start_game
            elsif question == "Yes"
                #procede to the actual game
                @character = Character.find_or_create_by(name: "Luminol", role: "Mage", description: "", hp: 90, level: 1, experience_points: 0, user_id: @current_user.id, attack_power: 9, current_weapon: nil, base_hp: 90,  base_attk: 9)
            end
        else 
            system('clear')
            exit
        end
    end

    def self.how_to_play
        # Go back
        # Finish up how-to-play
        puts "Click on Start button, select your character & view their respective stats. Choose another character if not pleased. Then confirm,
        hop into the game and try to survive defeated enemies and collecting useful items."
        choice = @@prompt.select("", ["Back", "Exit"])
        if choice == "Back"
            self.user_menu
        else
            exit
        end
    end

    def self.in_game_menu
      choice = @@prompt.select("Menu") do |menu|
          menu.choice "View Inventory", 1
          menu.choice "View Character Stats", 2
          menu.choice "Return to Game", 3
      end

      case choice
      when 1 
        @character.display_inventory
        @@prompt.keypress("Return to Menu", keys: [:space, :return])
        self.in_game_menu
      when 2
        @character.display_character_stats
        @@prompt.keypress("Return to Menu", keys: [:space, :return])
        self.in_game_menu
      when 3
         exit
      end
    end 

    #Story
    def self.story_introduction
        system('clear')
        sleep(1)
        #puts description of the World and Enviornment
        puts "\n You are #{@character.name}. #{@character.description}."
        puts "\n You wake up in an empty dungeon cell. Its dark and cold, you can barely see in front of you."
        puts "\n Suddenly the gate to your cell falls open allowing you to escape. You don't know where you are or how you got here."
        puts "\n All you know is that you must find a way out of here. \n\n"
        @@prompt.keypress("Press space or enter to continue", keys: [:space, :return])
        system('clear')
        puts "\n You cautiously step outside of cell. You find yourself in a long hallway with only one exit."
        puts "\n As you walk to end of the hallway you pass by other empty cells. You seem to be alone."
        puts "\n At the end of the hallway, you find a lantern on the floor"
        puts "\n You pick it up since this is will be your only light source.\n\n"

        #Character picks up the Lantern, this is the first item added to inventory
        encounter_intro = @character.ecounter_item_random
        @character.add_item_to_inventory("Lantern", "Misc", "A rusty Lantern that has plenty of oil.", encounter_intro)
        

        puts "\n\n After equiping and turning on the lantern. You realize you are standing in front of a large door."
        puts "\n You push open the heavy door and begin your journey to find your way home \n\n"
        @@prompt.keypress("Press space or enter to continue", keys: [:space, :return])
        system('clear')
    end 

    #Story

    def self.story_out_cell
        system('clear')
        sleep(1)
        puts "\nAfter opening the door, you find yourself in another corriodor. Similar to the previous one, this corridor has one door at the very end." 
        puts "\nAs you walk closer to the door, you see that the hallway makes a turn to the left. You can barely see what is at"
        puts "the end of the narrow hallway but you do hear the sound of swords clashing. The door in front of you is dark red and rusted."
        puts "You can vaguely hear people whispering on the otherside.\n\n"
        
        choice = @@prompt.select("What would you like to do?") do |menu|
            menu.choice "Continue down the hallway", 1
            menu.choice "Open the Red Door", 2 
            menu.choice "Menu", 3 
        end 

        case choice
        when 1
            #This leads to a battle 
            puts "placehoalder text"
        when 2
            #This leads to a weapon
            puts "moore blah text"
        when 3
            #define in gmae menu method
            self.in_game_menu
            #comes back to this prompt agaon after visting the menu where you can view your inventory and stats
            self.story_out_cell
        end
    end 

    
    #In game menu -- options: (View Inventory, View Stats, Quit)


    # Then after intro hop into story line --> FUN BUNCH OF STRINGSSS


    # Results win/loss/getting an item

    # Eventually one shotting the BOSS :D

end 
# binding.pry