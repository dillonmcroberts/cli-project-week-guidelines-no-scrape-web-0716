class Team

extend GetAll
attr_accessor :players_link, :average_age, :players, :age_sum, :calculate_age
attr_reader :name 

@@all_teams = []
  
  def initialize(name)
    @name = name
    @players = []
    @@all_teams << self
  end

  def self.all
    @@all_teams
  end

  def self.determine_age
    age_sum = 0
    all.each do |team| 
      team.players.each do |player|
        age_sum += calculate_age(player.birth_date)
      end
      if team.players.count > 0
        team.average_age = age_sum/team.players.count
      end
      age_sum = 0
    end
  end
  def self.calculate_age(player_age)
    year =Time.new.year
    month = Time.new.month
    day = Time.new.day
    birthday_array = player_age.split("-")
    age = year.to_i - birthday_array[0].to_i
    if month < birthday_array[1].to_i
      age -= 1
    end
    age
  end

end
