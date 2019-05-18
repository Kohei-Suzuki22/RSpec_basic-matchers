# require_relative "../lib/shoping_cart"
require "spec_helper"

RSpec.describe ShoppingCart do 
  let(:cart){ShoppingCart.new}
  
  describe "#add(item)" do
    
    context "nilを追加" do 
      
      it "エラーが発生する" do 
        expect{cart.add(nil)}.to raise_error "added item is nil."
      end
    end
  end
end
