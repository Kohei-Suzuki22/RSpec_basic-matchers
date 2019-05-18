
# require "../lib/lottery"
require "spec_helper"

RSpec.describe Lottery do 
  
  let(:results){Lottery.generate_results(10000)}
  let(:win_count){results.count(&:win?)}
  let(:probability){win_count.to_f / 10000 * 100}
  
  describe "抽選率が25.0 ± 1 % になること" do 
    context "抽選率" do 
      it "約25%" do 
        expect(probability).to be_within(1.0).of(25.0)
      end
    end
  end
  
  # it '当選確率が約25%になっていること' do
  #   # results = Lottery.generate_results(10000)
  #   # win_count = results.count(&:win?)
  #   # probability = win_count.to_f / 10000 * 100
  
  #   expect(probability).to be_within(1.0).of(25.0)
  # end
  
end
