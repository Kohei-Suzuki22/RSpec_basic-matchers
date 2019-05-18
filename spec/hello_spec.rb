# require_relative "../lib/hello"

require "spec_helper"

RSpec.describe Hello do 
  it "message return hello" do 
    expect(Hello.new.message).to eq "hello"
  end
  
  #マッチャの前に使うRSpecのメソッド
  
  # 1.to(~であること)
  # 2.not_to, to_not (~でなはないこと) → どっちをつかってもよい(読みやすい方を選択できれば尚○)
  it {expect(1+2).to eq 3}
  it {expect(1+2).to_not eq 1}
  it {expect(1+2).not_to eq 5}
  
  #マッチャ
  
  # eq → 「等しい」かどうか検証(==)
  it {expect(1+2).to eq 3}
  
  # be → 等号、不等号と組合せ「値の大小」を検証
  it {expect(1+2).to be >= 3}
  it {expect(1+6).to be > 5}
  # 等号、不等号なしでも使える。(左右のインスタンスが同一かどうかを検証。)(equal?)
  it {expect(1+2).to be 3}
  
  

  # ※eqとbeの違い
  message1 = "hello"
  message2 = "hello"
  
  # it{expect(message1).to be message2}   #検証失敗。(同一メソッドではないから)
  it{expect(message1).to eq message2}
  
  # true, false, nil ,StringClass, SymbolClass はbeでもeqでもパス。→「これらは同じ値であれば同じインスタンス  」 
  it{expect(message1).to be message1}
  it{expect(message1).to eq message1}
  
  it{expect(true).to be true}
  it{expect(true).to eq true}
  
  it{expect(false).to be false}
  it{expect(false).to be false}
  
  it{expect(nil).to be nil}
  it{expect(nil).to eq nil}
  
  it{expect(1+1).to be 2}
  it{expect(1+1).to eq 2}
  
  hello = :hello
  hi = :hello
  
  it{expect(hello).to be hi}
  it{expect(hello).to eq hi}
  
  # be_xxx(predicateマッチャ) → メソッド名が「?」で終わり、戻り値がfrue/falseを示すメソッドのときに使える.
  
  it{expect([].empty?).to be true}
  it{expect([]).to be_empty}
  it{expect([2]).not_to be_empty}
  
=begin

      #例 (railsのモデルのバリデーションを検証)
        
      user = User.new(name:"Bob",email: "bob@example.com")
      it{expect(user).to be_valid}
  
=end
  

  # be_truthy/be_falsey → 「?」では終わらないが、戻り値としてtrue/falseを返すメソッドを検証

=begin

      #例 (railsのモデルのsaveメソッド)
      
      user = User.new 
      it{expect(user.save).to be_truthy}

=end
  
  # be_truthy/be_falsey と　be true/ be false の違いは?
  #                     ↓
  #                     ↓
  # be_truthy/be_Falseyは、真「true」/偽「falseまたはnil」を検証。
  # be true(eq true)/ be false(eq false)は、「true」自体/「false」自体であるかを検証。
  
  it{expect(1).to be_truthy}    #検証パス
  # it{expect(1).to be true}    #検証失敗(1 == true は正しくないため。→１はtrue自体ではない)
  
  it{expect(nil).to be_falsey}  #検証パス
  # it{expect(nil).to be false}   #検証失敗(nil == false は正しくないため。→nilはfalse自体ではない)
  
  
  
  
  # expect{x}.to change{Y}.from(A).to(B) → 「XするとYがAからBに変わることを期待する。」
  # expect{x}.to change{Y}.by(Z) → 「XするとYがZ分だけ変化することを期待する。」
  
  #注意..expectとchangeのうしろは()ではなく{}　→ Rubyの文法的にブロック{}を渡すことと同じ。
  
  a1 = [1,2,3]
  it{expect{a1.pop}.to change{a1.size}.from(3).to(2)}
  a2 = [1,2,3]
  it{expect{a2.pop}.to change{a2.size}.by(-1)}
  a3 = [1,2,3]
  it{expect{a3.push(10)}.to change{a3.size}.from(3).to(4)}
  a4 = [1,2,3]
  it{expect{a4.push(10)}.to change{a4.size}.by(+1)}
  
=begin 
  
      #例 (railsを使った関連づけ「dependent: :destroy」を検証 )
      
      class User < ActiveRecord::Base 
        has_many :blogs, dependent: :destroy
      end
      
      
      class Blog < ActiveRecord::Base
        belongs_to :user
      end
      
      
      it "userを削除すると、userが書いたblogも削除されること" do 
        user = User.create(name:"Bob", email: "bob@example.com")
        user.blogs.build(title:"RSpec必勝法",content:"後で書く")
        
        expect{user.destroy}.to change{Blog.count}.by(-1)
      end
      
      it "userを削除すると、userが書いたblogも削除されること" do 
        let!(:user){User.create(name:"Bob", email: "bob@example.com")}
        user.blogs.build(title:"RSpec必勝法",context:"後で書く")
        
        expect{user.destroy}.to change{Blog.count}.by(-1)
        
      end
      
=end


  # [配列|ハッシュ|文字列] + include → 配列 or ハッシュ or 文字列 に期待したものが含まれているか
  
  x = [1,2,3]
  
  it{expect(x).to include(1)}
  it{expect(x).to include(2,3)}
  
  h = {name:"taro",age: 4,email: "taro@example.com"}
  
  it{expect(h).to include(:name)}
  it{expect(h).to include(:age,:email)}
  
  
  str = "hello I'm Bob"
  
  it{expect(str).to include("Bob")}
  it{expect(str).to include("h","e","b","o")}
  
  
  # raise_error "エラーメッセージ or エラークラス" → 「エラーが起きること」を検証
  
  #注意.. expectのうしろは()ではなく{}
  
  it{expect{1/0}.to raise_error ZeroDivisionError}
  it{expect{1/0}.to raise_error(ZeroDivisionError)}
  # エラーのクラスを指定しなくても正常に動作する。
  it{expect{1/0}.to raise_error}
  

end