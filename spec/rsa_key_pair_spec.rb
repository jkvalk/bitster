describe 'RSAKeyPair' do

  before(:all) do
    @key_pair = RSAKeyPair.new(len: 1024).generate!
  end

  it 'should have pub key' do
    expect(@key_pair.public_key).to be_an_instance_of(RSAPubKey)
  end

  it 'should have private key' do
    expect(@key_pair.private_key).to be_an_instance_of(RSAPrivateKey)
  end

end