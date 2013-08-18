class Interaction
	attr_reader :input, :output

	def initialize(input, output)
		@input = input
		@output = output
	end

	def attempt
		if should_call
			call_actionable
		end
	end
	
	def should_call
		input[:device].send(input[:action])
	end

	def call_actionable
		output[:device].send(output[:action])
	end

end

