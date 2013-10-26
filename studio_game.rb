require_relative 'game'

#KNUCKLEHEADS#
# player1 = Player.new("moe")
# player2 = Player.new("larry", 60)
# player3 = Player.new("curly", 125)
# player4 = Player.new("shemp", 90)
knucklheads = Game.new("knucklheads")
knucklheads.load_players(ARGV.shift || "players.csv")
klutz = ClumsyPlayer.new('klutz', 105)
knucklheads.add_player(klutz)
# knucklheads.add_player(player1)
# knucklheads.add_player(player2)
# knucklheads.add_player(player3)
# knucklheads.play(3)
# knucklheads.print_stats

loop do
  puts "\nHow many game rounds? ('quit' to exit)"
  answer = gets.chomp.downcase
  case answer
  when /^\d+$/
    knucklheads.play(answer.to_i)
  when "quit", "exit", "q"
    knucklheads.print_stats
    knucklheads.save_high_scores
    break
  else
    puts "Please enter a number or 'quit'"
  end
end