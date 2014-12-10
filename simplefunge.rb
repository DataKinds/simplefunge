if ARGV.length != 1
	puts "Must take input file as single argument."
	exit
end

program = ARGF.read.split(?\n)#.map{|line| line.split() }
pointer = [0, 0]
direction = :right #left up down
$stack = []
ins = ""
done = false

def genericOneArg()
	if $stack.length == 0
		yield 0
	else
		yield $stack.shift
	end
end

def genericTwoArg()
	if $stack.length == 0
		yield 0, 0
	elsif $stack.length == 1
		yield $stack.shift, 0 
	else
		yield $stack.shift, $stack.shift
	end
end

while not done
	begin 
		ins = program[pointer[1]][pointer[0]]
	rescue
		ins = :out_of_range
	ensure
		case ins
		when ?>
			direction = :right
		when ?<
			direction = :left
		when ?^
			direction = :up
		when ?v
			direction = :down
		when ?H
			genericOneArg { |n1| direction = n1 > 0 ? :right : :left }
		when ?V
			genericOneArg { |n1| direction = n1 > 0 ? :up : :down }
		when ??
			direction = [:up, :down, :left, :right].choose
		when ?I
			$stack.unshift STDIN.getc.ord
		when ?i
			$stack.unshift gets.chomp.to_i
		when ?O
			print $stack[0].chr
		when ?o
			print $stack[0]
		when ?n
			puts
		when ?+
			genericTwoArg { |n1, n2| $stack.unshift(n1 + n2) }
		when ?-
			genericTwoArg { |n1, n2| $stack.unshift(n1 - n2) }
		when ?*
			genericTwoArg { |n1, n2| $stack.unshift(n1 * n2) }
		when ?/
			genericTwoArg { |n1, n2| $stack.unshift(n1 / n2) }
		when ?`
			$stack.shift if $stack.length > 0
		when ?!
			genericOneArg { |n1| $stack.unshift n1; $stack.unshift n1; } #genericOneArg is destructive
		when ?&
			genericTwoArg { |n1, n2| $stack[0] = n2, $stack[1] = n1 }
		when ?| #can't figure out how to do this one generically
			i = $stack.shift
			if i >= $stack.length
				$stack.unshift 0
			else
				$stack.unshift $stack.slice!(i)
			end
		when ?.
			genericTwoArg { |n1, n2| $stack.insert(n1, n2).collect! { |el| el.nil? ? 0 : el } } 
		when ?@
			done = true
		when ?#
			print $stack
		when /\d/
			$stack.unshift ins.to_i

		#handle errors
		when :out_of_range
			puts "Out of range!"
			done = true
		end

		case direction
		when :right
			pointer[0] += 1
		when :left
			pointer[0] -= 1
		when :down
			pointer[1] += 1
		when :up
			pointer[1] -= 1
		end
	end
end