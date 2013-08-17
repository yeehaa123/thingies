require_relative '../lib/thingies'

describe Hub do

  let(:hubbie) { Hub.new("hubbie1", [:on, :off]) }
  let(:thingie2) { Device.new("thingie2", [:louder, :softer]) }

  context "should listen for available devices" do

    context "with no other available devices" do
      it "should return an empty list" do
        hubbie.listen.should == []
      end

      it "should present itself" do
        hubbie.present == true
      end
      
      it "should have a url" do
        hubbie.url.should match /druby:\/\/.+:\d{4}/
      end

      it "should have a list of behaviors" do
        hubbie.behaviors.should_not be_empty
        hubbie.behaviors.each do |behavior|
          behavior.class.should == Behavior
        end
      end
    end

    context "with 1 other available devices" do
      
      before do
        DRbObject.stub(:new_with_uri => thingie2)
      end

      it "should register the other device" do
        hubbie.register_device("thingie2").should == thingie2
      end
    end
    
    context "with 1 registered device" do

      before do
        DRbObject.stub(:new_with_uri => thingie2)
        hubbie.register_device("thingie2")
      end

      it "should return a list with one device" do
        hubbie.environment.should == [ thingie2 ]
      end
    end
  end
end
