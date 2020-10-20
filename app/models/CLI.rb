class CLI 
    @@prompt = TTY::Prompt.new

    def self.login
        system('clear')
        user_choice = @@prompt.select("This is the menu",["Log In", "Create Account", "Leaderboards", "Exit"])
        if user_choice == "Log In"
            system("clear")
            puts "Enter Your Information:"
            user_name = @@prompt.ask("Username:")
            password = @@prompt.mask("Password:")
            User.exists?(user_name: user_name, password: password)
        elsif
            user_choice == "Create Account"
            user_name = @@prompt.ask("Username:")
            password = @@prompt.mask("Password:")
            User.create(user_name: user_name, password: password)
        elsif
            user_choice == "Leaderboards"
        elsif
            user_choice == "Exit"
            exit
        end
    end

    # After user logs in, bring up another menu/options. Ex: Start Game, Instructions/How-to-play, Exit
    def self.main_menu
    end
end 