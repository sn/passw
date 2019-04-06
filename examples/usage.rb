require '../lib/wobbly'

puts "Basics:\n"

puts Wobbly.in('3s')
puts Wobbly.in('5m')
puts Wobbly.in('1h')
puts Wobbly.in('6D')
puts Wobbly.in('12M')
puts Wobbly.in('1Y')
puts Wobbly.in('8W')
puts Wobbly.in('2M')

puts "Combinations:\n"

puts Wobbly.in('1h12m8s')
puts Wobbly.in('12Y20s')
puts Wobbly.in('12Y3W6h')
