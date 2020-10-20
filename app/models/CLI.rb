class CLI 
    @@prompt = TTY::Prompt.new

    def self.main_menu
        system('clear')
        user_choice = @@prompt.select("This is the menu",["Log In", "Create Account", "Leaderboards", "Exit"])
        if user_choice == "Log In"
            user_name = @@prompt.ask("Username:")
            password = @@prompt.mask("Password:")
            if User.find_by(user_name: user_name, password: password)
                puts "Welcome #{user_name}"
                self.login
            end
        elsif
            user_choice == "Create Account"
            user_name = @@prompt.ask("Username:")
            password = @@prompt.mask("Password:")
            User.create(user_name: user_name, password: password)
            puts "Welcome #{user_name}"
        elsif
            user_choice == "Leaderboards"
        elsif
            user_choice == "Exit"
            exit
        end
    end

    # After user logs in, bring up another menu/options. Ex: Start Game, Instructions/How-to-play, Exit
    def self.user_menu
        choice = @@prompt.select("Just a test", ["Start", "How-to-play", "Exit"])
        #Start
        if choice == "Start"
            start_game
        #How-to-play - #back
        elsif choice == "How-to-play"
            instruction
        #Exit
        elsif
            exit
        end
    end
end 