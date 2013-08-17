describe Server do
  let(:thingie) { Server.new("thingie1", [:on, :off]) }
  let(:drb_server) { mock("Mock DRb Server") }

  context "it does not exist yet" do
    before do
      DRb.should_receive(:start_service).with(thingie.url, thingie).and_return(drb_server)
    end

    it "makes itself available" do
      thingie.present.should == drb_server 
    end
  end
end
