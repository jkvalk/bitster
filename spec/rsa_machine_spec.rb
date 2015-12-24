describe 'RSAMachine' do

  before(:all) do
    begin
      @key_pair = RSAKeyPair.new(360)
    rescue
      nil
    end
  end

  it 'should encrypt and decrypt' do
    machine = RSAMachine.new(:keypair => @key_pair)
    ctext = machine.encrypt(123)

    expect(machine.decrypt(ctext)).to eq(123)
  end
end