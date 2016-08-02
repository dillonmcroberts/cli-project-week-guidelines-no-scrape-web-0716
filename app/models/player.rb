class Player

@@all_players = []
  extend GetAll
  attr_accessor :name, :birth_date, :team
  def initialize(name, birth_date, team)
    @name = name
    @birth_date = birth_date
    @team = team
    team.players << self
    @@all_players << self
  end

  def self.all
    @@all_players
  end
end