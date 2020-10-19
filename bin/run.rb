require_relative '../config/environment'


@@prompt = TTY::Prompt.new

def menu
    user_choice = @@prompt.select("This is the menu",["Log In", "Create Account", "Leaderboards", "Exit"])
    if user_choice == "Log In"
        system("clear")
        "Enter Your Information"
    elsif
        user_choice == "Create Account"
        user_name = @@prompt.ask("Username:")
        password = @@prompt.mask("Password:")
        User.create(name: user_name, user_name: user_name, password: "")
    elsif
        user_choice == "Leaderboards"
    elsif
        user_choice == "Exit"
    end
end


menu
