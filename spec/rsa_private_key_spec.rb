describe 'RSAPrivateKey' do

  before(:all) do
    begin
      len = 512
      p = rand(2..((2**len/2)-1))
      q = rand(2..((2**len/2)-1))
      exp = rand(2..((2**len/2)-1))
      @key = RSAPrivateKey.new(p, q, exp, len)
    rescue
      nil
    end

  end

  it 'should initialize' do
    expect(@key).to be_instance_of(RSAPrivateKey)
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