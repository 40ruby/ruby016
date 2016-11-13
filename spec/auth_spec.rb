#filename: auth_spec.rb
require_relative '../auth'

describe "Authクラス" do
  describe "#authenticate メソッド" do
    context "正常に認証された場合" do
      it '標準で登録されている認証コードでコール' do
        a = Auth.new
        expect(a.authenticate('DEMO', '192.168.0.10')).not_to eq(false)
      end
      it '変更された認証コードでコール' do
        a = Auth.new('6996e0d11d644910e921ecc240f3cea8')
        expect(a.authenticate('40ruby', '192.168.0.10')).to eq('067745a1ca5c03b681e5935bb2f87ab7')
      end
    end

    context "異なる認証キーでコール" do
      it '標準で登録されている認証コード以外でコール' do
        a = Auth.new
        expect(a.authenticate('TEST', '192.168.0.10')).to eq(false)
      end
      it '変更された認証コードに対し、標準コードでコール' do
        a = Auth.new('6996e0d11d644910e921ecc240f3cea8')
        expect(a.authenticate('DEMO', '192.168.0.10')).to eq(false)
      end

    end
  end

  describe "#varid メソッド" do
    before do
      @a   = Auth.new
      @key = []
      0.step(10) do |num|
        @key[num] = @a.authenticate('DEMO', "192.168.0.#{num}")
      end
    end
    context "正常に登録されている場合" do
      it 'IPアドレスと登録されているコードがマッチしている' do
        0.step(10) do |num|
          expect(@a.varid(@key[num])).to eq("192.168.0.#{num}")
        end
      end
    end
  end
end
