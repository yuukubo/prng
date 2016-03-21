require "digest/sha2"
require "readline"
# generate 10 pseudo random number with sha256

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

puts
puts "generate 10 pseudo random number with sha256"
puts
puts "seed : #{iseed} "
puts

10.times do |wkctr|
	prn = Digest::SHA256.hexdigest "#{istate}"
	puts prn
	istate += 1
end

puts
puts "process end"
sleep(2)
