require 'pry'
class CLI 
    @@prompt = TTY::Prompt.new
    @@pastel = Pastel.new
    @@font = TTY::Font.new(:doom)

    def self.title
        system('clear')
        sleep(1)
        puts @@pastel.red(@@font.write("ROGUEE!", letter_spacing: 4))
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
        choice = @@prompt.select("Welcome #{@current_user.user_name}", ["Start", "How-to-play", "Exit"])
        #Start
        if choice == "Start"
            self.start_game
        #How-to-play - #back
        elsif choice == "How-to-play"
            self.how_to_play
        #Exit
        elsif
            exit
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
            puts "Name: Grimsborth"
            puts "Role:    Warrior"
            puts "----------------"
            puts "HP:          150"
            puts "Attack:       10"
            puts "----------------"
            question = @@prompt.select("Are you sure?", ["y", "n"])
            if question == "n"
                system('clear')
                self.start_game
            elsif question == "y"
                #procede to the actual game
                @character = Character.create(name: "Grimsborth", role: "Warrior", description: "", hp: 150, level: 1, experience_points: 0, user_id: @current_user.id, attack_power: 10)
            end
        when 2
            sleep(1)
            puts "Name: Kinklesburg"
            puts "Role:   Mercenary"
            puts "----------------"
            puts "HP:          100"
            puts "Attack:        7"
            puts "----------------"
            question = @@prompt.select("Are you sure?", ["y", "n"])
            if question == "n"
                system('clear')
                self.start_game
            elsif question == "y"
                #procede to the actual game
                @character = Character.create(name: "Kinklesburg", role: "Mercenary", description: "", hp: 100, level: 1, experience_points: 0, user_id: @current_user.id, attack_power: 7)
            end
        when 3
            sleep(1)
            puts "Name:     Croseus"
            puts "Role:    Huntress"
            puts "----------------"
            puts "HP:          110"
            puts "Attack:        5"
            puts "----------------"
            question = @@prompt.select("Are you sure?", ["y", "n"])
            if question == "n"
                system('clear')
                self.start_game
            elsif question == "y"
                #procede to the actual game
                @character = Character.create(name: "Croseus", role: "Huntress", description: "", hp: 110, level: 1, experience_points: 0, user_id: @current_user.id, attack_power: 5)
            end
        when 4
            sleep(1)
            puts "Name:    Luminol"
            puts "Role:       Mage"
            puts "----------------"
            puts "HP:           90"
            puts "Attack:        9"
            puts "----------------"
            question = @@prompt.select("Are you sure?", ["y", "n"])
            if question == "n"
                system('clear')
                self.start_game
            elsif question == "y"
                #procede to the actual game
                @character = Character.create(name: "Luminol", role: "Mage", description: "", hp: 90, level: 1, experience_points: 0, user_id: @current_user.id, attack_power: 9)
            end
        else 
            system('clear')
            exit
        end
    end

    def self.how_to_play
        # Go back
        # Finish up how-to-play
        choice = @@prompt.select("Do lateer!", ["Back", "Exit"])
        if choice == "Back"
            self.user_menu
        else
            exit
        end
    end

    #Starting The Game with an introduction
    def self.introduction
        #puts description of the World and Enviornment
        puts "You are #{@character.name}. #{@character.description}."
        puts "\n "
        
    end 

    # Then after intro hop into story line --> FUN BUNCH OF STRINGSSS

    # Then we add in combat (randomize attks(.sample method))

    # Method for stats & inventory

    # Results win/loss/getting an item

    # Eventually one shotting the BOSS :D

end 
# binding.pry