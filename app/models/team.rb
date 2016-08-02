class Team

attr_accessor :players_link
attr_reader :name, :players

@@all_teams = []
  
  def initialize(name)
    @name = name
    @players = []
    @@all_teams << self
  end

  def self.all
    @@all_teams
  end

end
