require 'pry'
class CLI 
    @@prompt = TTY::Prompt.new
    @@pastel = Pastel.new
    @@font = TTY::Font.new(:doom)
    @@spinner = TTY::Spinner.new("[:spinner] Processing ...", format: :bouncing_ball)

    #MAIN MENU =====================================================================================
    def self.title
        system('clear')
        sleep(1)
        puts @@pastel.red.bold(@@font.write("ROGUEE!".center(25), letter_spacing: 4))
    end

    def self.main_menu
        sleep(1)
        user_choice = @@prompt.select("") do |menu|
            menu.choice "Login".center(145), 1
            menu.choice "Create Account".center(145), 2
            menu.choice "Exit".center(145), 3
        end
        
        case user_choice
        when 1
            self.log_in
        when 2
            self.create_account
        when 3
            system('clear')
            exit
        end
    end

    def self.log_in
        system('clear')
        self.title
        user_name = @@prompt.ask("Username:")
        password = @@prompt.mask("Password:")
        if User.find_by(user_name: user_name, password: password)
            @current_user = User.find_by(user_name: user_name, password: password)
            system('clear')
            self.user_menu
        else
            system("clear")
            self.title
            choice = @@prompt.select("Username/Password is incorrect") do |menu|
                menu.choice "Retry".center(145), 1
                menu.choice "Create A New Account".center(145), 2
            end

            if choice == 1
                system("clear")
                self.log_in
            elsif choice == 2
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
    #=====================================================================================

    #USER MENU =====================================================================================
    # After user logs in, bring up another menu/options. Ex: Start Game, Instructions/How-to-play, Exit
    def self.user_menu
        sleep(1)
        system("clear")
        # puts "Welcome #{user_name}"
        choice = @@prompt.select(@@pastel.yellow("Welcome #{@current_user.user_name}\n\n".center(150))) do |menu| 
            menu.choice "Start".center(145), 1
            menu.choice "Select A Save".center(145), 2
            menu.choice "How-to-play".center(145), 3
            menu.choice "Update Account\n".center(145), 4
            menu.choice "Exit".center(145), 5
        end
        
        case choice
        #Start
        when 1
            self.start_game
        when 2
            @current_user.has_characters?
        #How-to-play - #back
        when 3
            self.how_to_play
        # Update account
        when 4
            self.account_update
        #Exit
        when 5
            exit
        end
    end

    # Able to change user_name & pw/ delete account
    def self.account_update
        choice = @@prompt.select("") do |menu|
            menu.choice "Update account name".center(145), 1
            menu.choice "Update password".center(145), 2
            menu.choice "Delete account\n".center(145), 3
            menu.choice "Back".center(145), 4
        end

        case choice
        when 1 
            new_name = @@prompt.ask("Input new username:")
            @current_user.update(user_name: new_name)
            @@spinner.auto_spin
            sleep(1)
            @@spinner.stop("Your username has been successfully updated")
            self.user_menu
        when 2 
            new_password = @@prompt.mask("Input new password:")
            @current_user.update(password: new_password)
            @@spinner.auto_spin
            sleep(1)
            @@spinner.stop("Your password has been successfully updated")

            # puts "Your password has been successfully updated"
            self.user_menu
        when 3
            are_you_sure = @@prompt.select("Are you sure?") do |menu|
                menu.choice "Yes".center(145), 1
                menu.choice "No".center(145), 2
            end

            if are_you_sure == 1
                @current_user.destroy
                @@spinner.auto_spin
                sleep(2)
                # puts "Your account has been successfully deleted"
                @@spinner.stop("Your account has been successfully deleted")
                self.main_menu
            elsif are_you_sure == 2
                self.account_update
            end
        when 4
            self.user_menu
        end
    end
    
    def self.how_to_play
        # Go back
        # Finish up how-to-play
        puts "Click on Start button, select your character & view their respective stats. Choose another character if not pleased. Then confirm,
        hop into the game and try to survive defeated enemies and collecting useful items.".center(145)
        choice = @@prompt.select("") do |menu|
            menu.choice "Back".center(145), 1
            menu.choice "Exit".center(145), 2
        end

        if choice == 1
            self.user_menu
        else
            exit
        end
    end

    #CHOOSE CHARACTER 
    def self.start_game
        # Characters to choose from:
        # Grimsborth, Kinklesburg, Croesus, Luminol
        # Role -> Huntress, Mercenary, Mage, Warrior
        # One Save for each character
        # "Choose Your Character, give an option like the menus, display base stats of that character, able to go back if they don't want that specific character"
        char = @@prompt.select("Choose your character:") do |menu|
            menu.choice "Grimsborth".center(145), 1
            menu.choice "Kinklesburg".center(145), 2
            menu.choice "Croseus".center(145), 3
            menu.choice "Luminol\n".center(145), 4
            menu.choice "Exit".center(145), 5
        end
        
        case char
        when 1
            grimsborth = Character.create(name: 'Grimsborth', role: 'Warrior', description: 'Combatant', hp: 150, level: 1, experience_points: 0, attack_power: 15 , current_weapon: 'Basic Broadsword', base_hp: 150)
            sleep(1)
            puts "\n"
            puts "----------------".center(145)
            puts "Name: Grimsborth".center(145)
            puts "Role:    Warrior".center(145)
            puts "----------------".center(145)
            puts "HP:          150".center(145)
            puts "Attack:       15".center(145)
            puts "----------------".center(145)
            choice = @@prompt.select("Are you sure?") do |menu|
                menu.choice "Yes".center(145), 1
                menu.choice "No".center(145), 2
            end

            if choice == 2
                system('clear')
                self.start_game
            elsif choice == 1
                if @current_user.has_specific_character?("Grimsborth")
                    puts "You already have a save with this character!"
                    self.start_game
                else
                    #procede to the actual game
                    @character = grimsborth
                    @character.update(user_id: @current_user.id)
                    self.story_introduction
                end 
            end
        when 2
            sleep(1)
            kinklesburg = Character.create(name: "Kinklesburg", role: "Mercenary", description: "", hp: 100, level: 1, experience_points: 0, attack_power: 12, current_weapon: "Basic Knife", base_hp: 100)
            sleep(1)
            puts "-----------------".center(145)
            puts "Name: Kinklesburg".center(145)
            puts "Role:   Mercenary".center(145)
            puts "-----------------".center(145)
            puts "HP:           100".center(145)
            puts "Attack:         #{kinklesburg.attack_power}".center(145)
            puts "----------------".center(145)
            question = @@prompt.select("Are you sure?") do |menu|
                menu.choice "Yes".center(145), 1
                menu.choice "No".center(145), 2
            end    

            if question == 2
                system('clear')
                self.start_game
            elsif question == 1
                if @current_user.has_specific_character?("Kinklesburg")
                    puts "You already have a save with this character!"
                    self.start_game
                else
                    #procede to the actual game
                    @character = kinklesburg
                    @character.update(user_id: @current_user.id)
                    self.story_introduction
                end
            end
        when 3
            sleep(1)
            croseus = Character.create(name: "Croseus", role: "Huntress", description: "", hp: 110, level: 1, experience_points: 0, attack_power: 11, current_weapon: 'Basic Bow', base_hp: 110)
            puts "----------------".center(145)
            puts "Name:    Croseus".center(145)
            puts "Role:   Huntress".center(145)
            puts "----------------".center(145)
            puts "HP:          110".center(145)
            puts "Attack:       #{croseus.attack_power}".center(145)
            puts "----------------".center(145)
            question = @@prompt.select("Are you sure?") do |menu|
                menu.choice "Yes".center(145), 1
                menu.choice "No".center(145), 2
            end
            
            if question == 2
                system('clear')
                self.start_game
            elsif question == 1
                if @current_user.has_specific_character?("Croseus")
                    puts "You already have a save with this character!"
                    self.start_game
                else
                    #procede to the actual game
                    @character = croseus
                    @character.update(user_id: @current_user.id)
                    self.story_introduction
                end
            end
        when 4
            luminol = Character.create(name: "Luminol", role: "Mage", description: "", hp: 90, level: 1, experience_points: 0, attack_power: 14, current_weapon: 'Basic Staff', base_hp: 90)
            sleep(1)
            puts "----------------".center(145)
            puts "Name:    Luminol".center(145)
            puts "Role:       Mage".center(145)
            puts "----------------".center(145)
            puts "HP:           90".center(145)
            puts "Attack:        #{luminol.attack_power}".center(145)
            puts "----------------".center(145)
            question = @@prompt.select("Are you sure?") do |menu|
                menu.choice "Yes".center(145), 1
                menu.choice "No".center(145), 2
            end
            
            if question == 2
                system('clear')
                self.start_game
            elsif question == 1
                if @current_user.has_specific_character?("Luminol")
                    puts "You already have a save with this character!"
                    self.start_game
                else
                    #procede to the actual game
                    @character = luminol
                    @character.update(user_id: @current_user.id)
                    self.story_introduction
                end
            end
        else 
            system('clear')
            exit
        end
    end

    def self.select_save
        puts "Here are your current saves:\n"
        puts "----------------------------------------------------"
        sorted_character_list = @current_user.characters.order(:id)
        sorted_character_names = sorted_character_list.map {|character| character.name}
        sorted_character_list.each do |character|
            puts "Name: #{character.name} --- Location: #{character.location}"
        end
        puts "\n"
        user_choice = @@prompt.select("Select A Save", [sorted_character_names])
        choice = @@prompt.select("Choose one of the following:") do |menu|
            menu.choice "Continue Save".center(145), 1
            menu.choice "Delete Save\n".center(145), 2
            menu.choice "Back".center(145), 3
        end 
        case choice
        when 1
            @character = Character.find_by(name: user_choice, user_id: @current_user)
            @character.where_am_i
        when 2
            Character.find_by(name: user_choice, user_id: @current_user).destroy
            @@spinner.auto_spin
            sleep(1)
            @@spinner.stop("Done!")
            self.user_menu
        when 3
            self.user_menu
        end 
    end 
    #=====================================================================================

    #IN GAME MENU ========================================================================
    def self.in_game_menu
        system('clear')
        puts @@pastel.blue.bold(@@font.write("User Menu".center(25), letter_spacing: 4))
        puts "========================================================================================================================================================"
        choice = @@prompt.select("Menu") do |menu|
            menu.choice "View Inventory".center(145), 1
            menu.choice "View Character Stats".center(145), 2
            menu.choice "Return to Game\n".center(145), 3
            menu.choice "Quit Game".center(145), 4
        end

        case choice
        when 1 
            @character.display_inventory
            # choice = @@prompt.select("Menu") do |menu|
            #     menu.choice "Use"
            @@prompt.keypress("Return to Menu", keys: [:space, :return])
            self.in_game_menu
        when 2
            @character.display_character_stats
            @@prompt.keypress("Return to Menu", keys: [:space, :return])
            self.in_game_menu
        when 3
            @character.where_am_i
        when 4
            self.main_menu
        end
    end 
    #=====================================================================================

    #STORY ===============================================================================
    def self.story_introduction
        @character.update(location: "Intro")
        system('clear')
        sleep(1)
        #puts description of the World and Enviornment
        puts @@pastel.green.bold("\nYou are #{@character.name} | #{@character.description}.".center(200))
        puts @@pastel.green.bold"\nYou wake up in an empty dungeon cell. Its dark and cold, you can barely see in front of you.".center(200)
        puts @@pastel.green.bold"\nSuddenly the gate to your cell falls open allowing you to escape. You don't know where you are or how you got here.".center(200)
        puts @@pastel.green.bold"\nAll you know is that you must find a way out of here. \n\n".center(200)
        @@prompt.keypress("Press space or enter to continue", keys: [:space, :return])
        system('clear')
        puts @@pastel.green.bold"\nYou cautiously step outside of cell. You find yourself in a long hallway with only one exit.".center(200)
        puts @@pastel.green.bold"\nAs you walk to end of the hallway you pass by other empty cells. You seem to be alone.".center(200)
        puts @@pastel.green.bold"\nAt the end of the hallway, you find a lantern on the floor".center(200)
        puts @@pastel.green.bold"\nYou pick it up since this is will be your only light source.\n\n".center(200)

        #Character picks up the Lantern, this is the first item added to inventory
        encounter_intro = @character.encounter_item_random
        lantern = Item.create(name: "Lantern", item_type: "Story Item", description: "A rusty Lantern that has plenty of oil.")
        @character.add_item_to_inventory(lantern, encounter_intro)
        

        puts @@pastel.green.bold("\nAfter equiping and turning on the lantern. You realize you are standing in front of a large door.".center(200))
        puts @@pastel.green.bold("You push open the heavy door and begin your journey to find your way home \n\n".center(200))
        @@prompt.keypress("Press space or enter to continue", keys: [:space, :return])
        system('clear')
        self.story_out_of_cell
    end 

    def self.story_out_of_cell
        @character.update(location: "Out of Cell")
        system('clear')
        sleep(1)
        puts @@pastel.green.bold("\nAfter opening the door, you find yourself in another corriodor. Similar to the previous one, this corridor has one door at the very end.".center(180)) 
        puts @@pastel.green.bold("As you walk closer to the door, you see that the hallway makes a turn to the left. You can barely see what is at".center(180))
        puts @@pastel.green.bold("the end of the narrow hallway but you do hear the sound of swords clashing. The door in front of you is dark red and rusted.".center(180))
        puts @@pastel.green.bold("You can vaguely hear people whispering on the otherside.\n\n".center(180))
        
        choice = @@prompt.select("What would you like to do?") do |menu|
            menu.choice "Continue down the hallway".center(145), 1
            menu.choice "Open the Red Door\n".center(145), 2 
            menu.choice "Menu".center(145), 3 
        end 

        case choice
        when 1
            self.story_continue_hallway
        when 2
            puts @@pastel.green.bold("Being the heroic an brave person you are, you open the door to find it....empty?")
            puts @@pastel.green.bold("The whispers that you heard are gone. The room is filled with paintings of blurred faces.")
            puts @@pastel.green.bold("On the ground you see something shiny")

            encounter_creepy_room = @character.encounter_item_random
            item = Item.all[0]
            @character.add_item_to_inventory(item, encounter_creepy_room)
            sleep(1)
            puts @@pastel.green.bold("Seeing nothing else in the room, you head back to the hallway.")
            @@prompt.keypress("Press space or enter to continue", keys: [:space, :return])
            self.story_continue_hallway

        when 3
            #define in gmae menu method
            self.in_game_menu
        end
    end

    def self.story_continue_hallway
        goblin = Enemy.create(name: "Goblin", role: "Jailor", description: "A goblin with a sword", hp: [75,80,100].sample, level: 1, attack_power: [5,6,8].sample, encounter_id: nil, boss: false)
        @character.update(location: "Hallway")
        system('clear')
        sleep(1)
    
        puts @@pastel.green.bold("You continue down the hallway. You hold out your lantern. This section of the hallway seems darker.".center(180))
        puts @@pastel.green.bold("As you walk, you pass by portraits of a shadowy figure. You feel as though you are being watched.".center(180))
        puts @@pastel.green.bold("\nYou hear footsteps coming from behind you. They get louder and louder. You turn around to see...nothing".center(180))
        puts @@pastel.green.bold("Maybe its just your imagination. You walk faster towards the end of the hallway. Before you can turn the corner, a goblin pops out.".center(180))
        puts @@pastel.green.bold("\nThe goblin looks at you with a grin. 'How did you get out of you cell?', he thinks out loud.".center(180))
        puts @@pastel.green.bold("\nBefore you can respond, he attacks you!".center(180))
        @@prompt.keypress("Press space or enter to continue", keys: [:space, :return])

        #battle start
        goblin = Enemy.create(name: "Goblin", role: "Jailor", description: "A goblin with a sword", hp: [75,80,100].sample, level: 1, attack_power: [5,6,8].sample, encounter_id: nil, boss: false)
        battle = @character.encounter_enemy
        enemy = Enemy.find_by(name: "Goblin")
        enemy.update(encounter_id: battle.id)
        battle.combat(@character, enemy)

        system('clear')
        puts @@pastel.green.bold("\nThe goblin falls over. He lies on the floor, barely concious, fully aware that he will die soon.".center(180))
        puts @@pastel.green.bold("You try to ask him where you are. He coughs up a laugh. 'Listen human, you are miles away from the surface' he says.".center(180))
        puts @@pastel.green.bold("'To get there, you would have to climb 10 floors and open the....gates' His voice trails off. And just like that he is dead.".center(180))
        puts @@pastel.green.bold("\n You wonder what the gates are. And what does he mean by surface? Is that home? Well, there is one way to find out.".center(180))
        @@prompt.keypress("Press space or enter to continue", keys: [:space, :return])
        
        self.story_key_pad_door

    end 

    def self.story_key_pad_door
        @character.update(location: "Keypad")
        system('clear')
        sleep(1)
    
        puts @@pastel.green.bold("\nStepping over the goblin's dead body, you finally turn the corner.")
        puts @@pastel.green.bold("You are met with a heavy metal door with a keypad. There is writing above that says:")
        puts @@pastel.green.bold("\n\n 'I am a three digit number.")
        puts @@pastel.green.bold("The second number is five more than the third.")
        puts @@pastel.green.bold("The first number is eight less than the third.")
        puts @@pastel.green.bold("Solving me is the key.'")
        puts "\n\n"
        puts @@pastel.green.bold("The keypad on the door has numbers 1-9 on it.\n")
        first_number = @@prompt.ask(@@pastel.blue.bold('Please Enter the first number:'))
        second_number = @@prompt.ask(@@pastel.green.bold('Please Enter the second number:'))
        third_number = @@prompt.ask(@@pastel.blue.bold('Please Enter the third number:'))
    
        code = first_number + second_number + third_number
        if code == "194"
            sleep(1)
            system('clear')
            puts @@pastel.green.bold("\nYou have successfully open the door!")
            puts @@pastel.green.bold("\n\nThe door open to a dimly lit room that appears to be a great hall.")
            puts @@pastel.green.bold("You step inside hoping for the best\n\n")
    
            @@prompt.keypress("Press space or enter to continue", keys: [:space, :return])
            self.story_boss_room
        else
            system('clear')
            puts @@pastel.red.bold("The keypad flashes red. You hear a loud buzz noise. The code must be wrong...")
            sleep(1)
            @@prompt.keypress("Press space or enter to continue", keys: [:space, :return])
            self.story_key_pad_door
        end
    end

    def self.story_boss_room
        @character.update(location: "Boss")
        system('clear')
        sleep(1)
        
        
        puts @@pastel.green.bold("\nAs you walk deeper into the room, torches planted on the walls start to light up one by one.")
        puts @@pastel.green.bold("The room turned out to be a great chamber with several pillars standing tall.")
        puts @@pastel.green.bold("Your footsteps echo in the room. At the end of the hall is a ladder ascending to the next floor")
        puts @@pastel.green.bold("You realize that ladder is your way up and closer to the 'surface'")
        puts @@pastel.green.bold("\nSuddenly the ground shakes causing dust to fall from the ceiling.")
        puts @@pastel.green.bold("Then a dragon breaks and climbs out of the ground! At first the giant four-winged gray dragon does not notice you.")
        puts @@pastel.green.bold("His skin appears to be covered in dark colored crystals. As he moves, his large tail swings from side to side.")
        puts @@pastel.green.bold("\nHe then sees you and starts to move his way over to you. His large figure causes the floor to crack at every step.")
        puts @@pastel.green.bold("Once he is in front of you, he roars. It seems that he wants to kill you! Prepare for a tought fight!")
        @@prompt.keypress("Press space or enter to continue", keys: [:space, :return])
        
        midir = Enemy.create(name: "Darkeater Midir", role: "Dragon", description: "A four winged crystalized dragon", hp: 160, level: 1, attack_power: [8,10,12].sample, boss: true)
        boss_battle = @character.encounter_enemy
        enemy = Enemy.find_by(name: "Darkeater Midir")
        enemy.update(encounter_id: boss_battle.id)
        boss_battle.combat(@character, enemy)
    
        system('clear')
        puts @@pastel.green.bold("\nAfter an exhausting fight, the dragon is defeated. The dragon slumps over making a huge thud noise.")
        puts @@pastel.green.bold("You walk around his body, wasting no time to get to the ladder. Before you begin to climb, you look back at the dragon.")
        puts @@pastel.green.bold("You wonder if the rest of your journey will be this hard.")
        sleep(1)
        @@prompt.keypress("Press space or enter to continue", keys: [:space, :return])
        self.end_of_demo
    end 

    def self.end_of_demo
        system('clear')
        puts @@pastel.yellow.bold("FLOOR 1 CLEARED".center(145))
        puts"\n\n"
        sleep(1)
        puts @@pastel.red.bold("END OF DEMO".center(145))
        puts"\n\n"
        sleep(1)
        puts @@pastel.magenta.bold("THANKS FOR PLAYING!".center(145))
        sleep(2)
    end
end 
# binding.pry

=begin 
            
        


=end 