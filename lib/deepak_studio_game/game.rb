require_relative 'player'
require_relative 'die'
require_relative 'game_turn'
require_relative 'treasure_trove'
require_relative 'clumsy_player'
require_relative 'berserk_player'

module DeepakStudioGame
  class Game
    attr_reader :title

    def initialize(title)
      @title = title
      @players = []
    end

    def add_player(player)
      @players << player
    end

    def load_players(from_file)
      File.readlines(from_file).each do |line|
        add_player(Player.from_csv(line))
      end
    end

    def save_high_scores(to_file="high_scores.csv")
      File.open(to_file, "w") do |file|
        file.puts "#{@title} High Scores:"
        @players.sort.each do |player| 
          file.puts high_score_entry(player)
        end
      end
    end

    def high_score_entry(player)
      formatted_name = player.name.ljust(20, ".")
      "#{formatted_name} #{player.score}"
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

    def total_points
      @players.each.reduce(0) { |sum, player| sum = sum + player.points}
    end

    def print_stats
      strong_players, wimpy_players = @players.partition { |player| player.strong? }

      puts "\n#{@title} Statistics:"

      puts "\n#{total_points} total points from treasures found"

      puts "\n#{strong_players.count} strong players:"
      strong_players.each {|player| print_name_and_health(player)}

      puts "\n#{wimpy_players.count} wimpy players:"
      wimpy_players.each {|player| print_name_and_health(player)}

      
      puts "\n#{@title} High Scores:"
      
      @players.sort.each do |player| 
        puts high_score_entry(player)
      end

      @players.each do |player|
        puts "\n#{player.name}'s point totals:"
        player.each_found_treasure do |treasure|
          puts "#{treasure.points} total #{treasure.name} points"
        end
        puts "#{player.points} grand total points"
      end
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