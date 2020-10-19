require_relative '../config/environment'

prompt = TTY::Prompt.new

def menu
    user_choice = prompt.select("This is the menu",["Log In", "Create Account", "Leaderboards", "Exit"])
end


menu
