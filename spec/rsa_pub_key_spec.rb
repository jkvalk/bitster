describe 'RSAPubKey' do

  before(:all) do
    len = 512
    mod = rand(2..((2**len)-1))
    exp = rand(2..((2**len/2)-1))
    @key = RSAPubKey.new(:modulus => mod, :exponent => exp, :len => len)
  end

  it 'should return padded hash' do
    expect(@key.get_hash).to include(:exponent, :modulus)
  end

  it 'should return json' do
    expect(@key.get_json).to be_instance_of(String)
    expect(@key.get_json).to match(/modulus/)
    expect(@key.get_json).to match(/exponent/)
  end

end