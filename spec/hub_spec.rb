require_relative '../lib/thingies'

describe Hub do

  let(:hubbie) { Hub.new("hubbie1", [:on, :off]) }
  let(:thingie1) { Device.new("thingie1", [:stop, :start]) }
  let(:thingie2) { Device.new("thingie2", [:louder, :softer]) }
  let(:drb_server) { mock("Mock DRb Server") }

  context "should listen for available devices" do

    context "with no other available devices" do

      it "should return an empty list" do
        hubbie.listen.should == []
      end

      
      it "should have a url" do
        hubbie.url.should match /druby:\/\/.+:\d{4}/
      end

      it "should have a list of behaviors" do
        hubbie.behaviors.should_not be_empty
        hubbie.behaviors.each do |interaction|
          interaction.class.should == Behavior
        end
      end

      context "make itself available" do
        before do
          DRb.should_receive(:start_service).with(hubbie.url, hubbie).and_return(drb_server)
        end
        it "should present itself" do
          hubbie.present == drb_server
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
   
    context "with registered devices" do 

      before do
        DRbObject.stub(:new_with_uri => thingie1)
        hubbie.register_device("thingie1")
      end

      context "with 1 registered device" do

        it "should return a list with one device" do
          hubbie.environment.should == [ thingie1 ]
        end

        it "should know this objects behaviors" do
          hubbie.environment.first.behaviors == thingie1.behaviors
        end
      end

      context "with 2 registered device" do


        it "should return a list with one device" do
          hubbie.environment.should == [ thingie1 ]
        end

        it "should know this objects behaviors" do
          hubbie.environment.first.behaviors == thingie1.behaviors
        end
      end

      context "with 2 registered device" do

        before do
          DRbObject.stub(:new_with_uri => thingie2)
          hubbie.register_device("thingie2")
        end

        it "should return a list with one device" do
          hubbie.environment.should == [ thingie1, thingie2 ]
        end

        it "should know all behaviors" do
        end
      end
    end
  end
end
