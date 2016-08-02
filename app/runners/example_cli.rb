class ExampleCLI

  def call
    puts "Welcome! What league would you like to search?"
    run
  end
    
  def get_user_input
    gets.chomp.strip
  end

  def run
    print "New search keyword: "
    input = get_user_input
    if input == "help"
      help
    elsif input == "exit"
      exit
    else
      search(input)
    end
    run
  end

  def search(input)
    search_term = input.split(" ")[0]
    puts "Your search term was #{search_term}, I am searching..."
    url = "http://api.football-data.org/v1/competitions/"
    tweet = APIWrapper.new(url)
    
    puts "Thank you for your patience. I found this on Twitter:"
    # puts tweet.example
  end

  def help
    puts "Type 'exit' to exit"
    puts "Type 'help' to view this menu again"
    puts "Type anything else to search for a league"
  end

end

