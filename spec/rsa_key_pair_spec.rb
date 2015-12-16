describe 'RSAKeyPair' do

  before(:all) do
    begin
      @key_pair = RSAKeyPair.new(1024)
    rescue
      nil
    end
  end

  it 'should initialize' do
    expect(RSAKeyPair.new(1024)).to be_an_instance_of(RSAKeyPair)
  end

  it 'should have pub key' do
    expect(@key_pair.public_key).to be_an_instance_of(RSAPubKey)
    #ap @key_pair.public_key.get_hash
  end

  it 'should have private key' do
    expect(@key_pair.private_key).to be_an_instance_of(RSAPrivateKey)
    #ap @key_pair.private_key.get_hash

  end

end