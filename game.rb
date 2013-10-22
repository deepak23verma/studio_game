require_relative 'player'
require_relative 'die'

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
      die = Die.new
      case die.roll
      when 1..2
        player.blam
      when 3..4
        puts "#{player.name} was skipped"
      else
        player.w00t
      end
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