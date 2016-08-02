class Player

@@all_players = []

  def initialize(name, birth_date)
    @name = name
    @birth_date = birth_date
    @@all_players << self
  end
end