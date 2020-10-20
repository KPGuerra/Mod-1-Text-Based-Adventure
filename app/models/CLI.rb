class CLI 
    @@prompt = TTY::Prompt.new

    def self.main_menu
        system('clear')
        user_choice = @@prompt.select("This is the menu",["Log In", "Create Account", "Leaderboards", "Exit"])
        if user_choice == "Log In"
            system("clear")
            self.log_in
        elsif
            user_choice == "Create Account"
            system("clear")
            self.create_account
        elsif
            user_choice == "Leaderboards"
        elsif
            user_choice == "Exit"
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
            self.instruction
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
            puts "Display stats"
            question = @@prompt.select("Are you sure?", ["y", "n"])
            if question == "n"
                self.start_game
            elsif question == "y"
                #procede to the actual game
                character = Character.create(name: "Grimsborth", role: "Warrior", description: "", hp: 150, level: 1, experience_points: 0, user_id: @current_user.id)
            end
            system('clear')
        when 2
            puts "Display stats"
            if question == "n"
                self.start_game
            elsif question == "y"
                #procede to the actual game
                character = Character.create(name: "Kinklesburg", role: "Mercenary", description: "", hp: 100, level: 1, experience_points: 0, user_id: @current_user.id)
            end
            system('clear')
        when 3
            puts "Display stats"
            if question == "n"
                self.start_game
            elsif question == "y"
                #procede to the actual game
                character = Character.create(name: "Croseus", role: "Huntress", description: "", hp: 110, level: 1, experience_points: 0, user_id: @current_user.id)
            end
            system('clear')
        when 4
            puts "Display stats"
            if question == "n"
                self.start_game
            elsif question == "y"
                #procede to the actual game
                character = Character.create(name: "Luminol", role: "Mage", description: "", hp: 90, level: 1, experience_points: 0, user_id: @current_user.id)
            end
            system('clear')
        else 
            system('clear')
            exit
        end
    end

    def self.instruction
        # Go back
        # Finish up instructions
        choice = @@prompt.select("Do lateer!", ["Back", "Exit"])
        if choice == "Back"
            self.user_menu
        else
            exit
        end
    end

    
end 