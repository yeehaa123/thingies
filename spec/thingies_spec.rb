require 'spec_helper'

describe Device do

  let(:thingie1) { Device.new("thingie1", [:on, :off]) }
  let(:thingie2) { Device.new("thingie2", [:louder, :softer]) }

  context "should listen for available devices" do

    context "with no other available devices" do
      it "should return an empty list" do
        thingie1.listen.should == []
      end

      it "should present itself" do
        thingie1.present == true
      end
      
      it "should have a url" do
        thingie1.url.should match /druby:\/\/.+:\d{4}/
      end

      it "should have a list of behaviors" do
        thingie1.behaviors.should_not be_empty
        thingie1.behaviors.each do |behavior|
          behavior.class.should == Behavior
        end
      end
    end

    context "with 1 other available devices" do
      
      before do
        DRbObject.stub(:new_with_uri => thingie2)
      end

      it "should register the other device" do
        thingie1.register_device("thingie2").should == thingie2
      end
    end
    
    context "with 1 registered device" do

      before do
        DRbObject.stub(:new_with_uri => thingie2)
        thingie1.register_device("thingie2")
      end

      it "should return a list with one device" do
        thingie1.environment.should == [ thingie2 ]
      end
    end
  end
end
