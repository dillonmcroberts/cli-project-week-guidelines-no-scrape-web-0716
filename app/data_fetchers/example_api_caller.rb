require "JSON"


class APIWrapper
  attr_accessor :url, :league_selection, :all_competitions, :team_url, :all_teams, :players_url, :player_hash

  
  def initialize(url)
    @url = url
    @all_competitions = JSON.load(open(url))
    load_leagues
  end

  def load_leagues
    user_input = "BL1"
    league_selection= @all_competitions.detect{|league| league["league"] == user_input}  
    self.team_url = league_selection["_links"]["teams"]["href"]
    load_teams
  end

  def load_teams
    self.all_teams = JSON.load(open(team_url))
    parse_teams
  end

  def load_players
    Team.all.each do |team|
      binding.pry
      player_hash = JSON.load(open(team.players_link))
      parse_players
    end
  end

  def parse_players
    player_hash["players"].each do |player|
      Player.new(player["name"], player["dateOfBirth"])
    end
  end


  def parse_teams
    self.all_teams["teams"].each do |team|
      Team.new(team["name"])
      Team.all.last.players_link = team["_links"]["players"]["href"]      
    end
    load_players
    binding.pry
  end


end


