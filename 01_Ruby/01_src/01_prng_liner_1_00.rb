require "readline"
# generate 100 pseudo random number with liner congruential method

intm = rand(1000..10000)
inta = rand(1..intm)
intc = rand(1..intm)
istate = 0
prn = 0
iseed = 0

iseed = Readline.readline("seed : type a number in 1 to 9 > ")
if iseed =~ /^[0-9]+$/
	istate = iseed.to_i
else
	puts "  type a number. try again! "
	sleep(2)
	exit(99)
end

puts "generate 100 pseudo random number with liner congruential method"
puts
puts "M : #{intm}, A : #{inta}, C : #{intc}, seed : #{iseed} "
puts

100.times do |ctr|
	prn = ( inta * istate + intc ) % intm
	istate = prn
	print "#{format("%04d",prn)} "
	puts " " if ( ( ctr + 1 ) % 10 ) == 0
end

puts
puts "process end"
sleep(2)
