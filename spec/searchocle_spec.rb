RSpec.describe Searchocle do
  it "has a version number" do
    expect(Searchocle::VERSION).not_to be nil
  end

  describe "#read" do
    before(:each) do
      @zhm = Searchocle::read("30594426", "testkey")
    end

    context "with default parameters" do
      it "returns a single record" do
        expect(@zhm).to be_a Nokogiri::XML::Document
        expect(@zhm.root.name).to eq "record"
      end
    end
  end

  describe "#sru" do
    before(:each) do
      @zhm = Searchocle::sru(%q{srw.au="Zora Neale Hurston" and srw.ti="Novels and stories"}, "testkey")
    end

    context "with default parameters" do
      xit "returns an Enmerator" do
        expect(@zhm).to be_a Enumerator
      end
    end
  end
end
