require_relative 'player'
require_relative 'die'
require_relative 'game_turn'
require_relative 'treasure_trove'

class Game
  attr_reader :title

  def initialize(title)
    @title = title
    @players = []
  end

  def add_player(player)
    @players << player
  end

  def play(rounds)
    puts "There are #{@players.size} players in #{@title}:"
    @players.each do |player|
      puts player
    end

    treasures = TreasureTrove::TREASURES
    puts "\nThere are #{treasures.size} treasures to be found"
    treasures.each do |treasure|
      puts "A #{treasure.name} is worth #{treasure.points} points"
    end

    1.upto(rounds) do |round|
      puts "\nRound #{round}"
      @players.each do |player|
        GameTurn.take_turn(player)
        puts player
      end
    end
  end

  def print_name_and_health(player)
    puts "#{player.name} (#{player.health})"
  end

  def print_stats
    strong_players, wimpy_players = @players.partition { |player| player.strong? }

    puts "\n#{@title} Statistics:"

    puts "\n#{strong_players.count} strong players:"
    strong_players.each {|player| print_name_and_health(player)}

    puts "\n#{wimpy_players.count} wimpy players:"
    wimpy_players.each {|player| print_name_and_health(player)}

    
    puts "\n#{@title} High Scores:"
    
    @players.sort.each do |player| 
      formatted_name = player.name.ljust(20, ".")
      puts "#{formatted_name} #{player.score}"
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