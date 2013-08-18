require_relative 'spec_helper'

describe Interaction do

	let(:device1) { Device.new("thingie1", [:on, :off])}
	let(:device2) { Device.new("thingie2", [:on, :off])}
	let(:input) {{ :device => device1, :action => :on }}
	let(:output) {{ :device => device2, :action => :off }} 
	let(:interaction) { Interaction.new(input, output) }

	it "should have input and output devices" do
		interaction.input.should have_key(:device)
		interaction.output.should have_key(:device)
	end

	it "should have an action for each device and it should be a key" do
		interaction.input.should have_key(:action)
		interaction.output.should have_key(:action)
	end
	
	context "attempting an interaction" do

		it "calls passed action on input device" do
			input[:device].should_receive(input[:action])
			interaction.attempt
		end

		it "calls output's action if conditional is met" do
			interaction.stub(:should_call => true)
			interaction.stub(:call_actionable => nil)
			interaction.should_receive(:call_actionable)
			interaction.attempt
		end

		it "does not call output's action if conditional is not met" do
			interaction.stub(:should_call => false)
			interaction.stub(:call_actionable => nil)
			interaction.should_not_receive(:call_actionable)
			interaction.attempt
		end

		it "call_actionable calls output's action on output's device" do
			def (output[:device]).off
				"lalla"
			end
			interaction.call_actionable.should == "lalla"
		end

	end

end
