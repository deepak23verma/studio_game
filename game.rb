require_relative 'player'

class Game
  attr_reader :title

  def initialize(title)
    @title = title
    @players = []
  end

  def add_player(player)
    @players << player
  end

  def play
    puts "There are #{@players.size} players in #{@title}:"
    @players.each do |player|
      puts player
    end

    @players.each do |player|
      player.w00t
      player.blam
      player.blam
      player.w00t
      puts player
    end
  end
end

if __FILE__ == $0
  clowns = Game.new("Clowns")
  player1 = Player.new("Crusty", 75)
  player2 = Player.new("Julian", 120)
  player3 = Player.new("Canon")
  clowns.add_player(player1)
  clowns.add_player(player2)
  clowns.add_player(player3)
  clowns.play
end