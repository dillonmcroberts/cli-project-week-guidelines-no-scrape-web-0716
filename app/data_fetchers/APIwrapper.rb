require "JSON"


class APIWrapper
  attr_accessor :url, :user_input, :league_selection, :all_competitions, :team_url, :all_teams, :players_url, :player_hash

  
  def initialize(url,user_input)
    @url = url
    @user_input = user_input
    @all_competitions = HTTParty.get(url,:headers => { "X-Auth-Token" => "baedd2363fed4adc9f9ab6491ab0fa76"})
    load_leagues
  end

  def load_leagues
    league_selection= @all_competitions.detect{|league| league["league"] == @user_input}  
    self.team_url = league_selection["_links"]["teams"]["href"]
    load_teams
  end

  def load_teams
    self.all_teams = HTTParty.get(team_url,:headers => { "X-Auth-Token" => "baedd2363fed4adc9f9ab6491ab0fa76"})
    parse_teams
  end

  def load_players
    Team.all.each do |team|
      self.player_hash = HTTParty.get(team.players_link,:headers => { "X-Auth-Token" => "baedd2363fed4adc9f9ab6491ab0fa76"})
      @team_temp = team
      parse_players
    end
  end

  def parse_players
    self.player_hash["players"].each do |play|
      Player.new(play["name"], play["dateOfBirth"],@team_temp)
    end
  end


  def parse_teams
    self.all_teams["teams"].each do |team|
      Team.new(team["name"])
      Team.all.last.players_link = team["_links"]["players"]["href"]      
    end
    load_players
  end

  def players
    Player.all.each {|play| puts "#{play.name} was born #{play.birth_date}"}
  end

  def print_age
      Team.determine_age
      Team.all.each do |team|
        puts "The average age for #{team.name} is #{team.average_age}"
      end
  end

end


