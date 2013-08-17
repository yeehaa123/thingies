require_relative 'spec_helper'

describe Device do
  let(:thingie) { Device.new("thingie1", [:on, :off]) }
  let(:drb_server) { mock("Mock DRb Server") }

  before do
    thingie.stub(:interactions => [:on, :off])
  end

  it "should know its behaviors" do
    thingie.interactions.should == [:on, :off]
    thingie.interactions.each do |interaction|
      interaction.class == Interaction
    end
  end

  context "it does not exist yet" do
    before do
      DRb.should_receive(:start_service).with(thingie.url, thingie).and_return(drb_server)
    end

    it "makes itself available" do
      thingie.present.should == drb_server 
    end
  end
end
