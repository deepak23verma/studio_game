def conversation
  puts "Hello"
  yield
  puts "Goodby"
end

conversation { puts "Good to meet you!"}

def five_times
  puts "\n"
  1.upto(5) do |n|
    yield n
  end
end

five_times do |n|
  puts "#{n} situps"
  puts "#{n} pushups"
  puts "#{n} chinups"
end

def n_times(number)
  puts "\n"
  1.upto(number) do |n|
    yield n
  end
end


n_times(3) do |n|
  puts "#{n} situps"
  puts "#{n} pushups"
  puts "#{n} chinups"
end