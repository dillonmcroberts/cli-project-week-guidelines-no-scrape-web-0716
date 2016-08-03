class ExampleCLI

  def call
    puts "Welcome! What league would you like to search?"
    puts "Please enter - EPL, Bundesliga, Ligue 1, La Liga, Serie A"
    run
  end
    
  def get_user_input
    gets.chomp.strip
  end

  def run
    array = ["epl", "bundesliga", "ligue 1", "la liga", "serie a"]
    print "New search keyword: "
    input = get_user_input
    if input == "help"
      help
    elsif input == "exit"
      exit
    elsif array.include?(input.downcase)
      search(input)
    end
    run
  end

  def search(input)
    hash = {"epl" => "PL", "bundesliga" => "BL1","ligue 1"=> "FL1","la liga" => "PD" , "serie a"=> "SA"} 
    search_term = hash[input]
    puts "Your search term was #{input}, I am searching..."
    url = "http://api.football-data.org/v1/competitions/"
    league_players = APIWrapper.new(url, search_term)
    
    puts "Thank you for your patience. I found this:"
    
    league_players.print_age
    binding.pry
  end

  def help
    puts "Type 'exit' to exit"
    puts "Type 'help' to view this menu again"
    puts "Type a listed league to search"
  end

end

