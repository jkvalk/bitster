describe 'RSAMachine' do

  before(:all) do
    begin
      @pubkey = RSAPubKey.new(
          modulus: 0x60ea9420ebbd34ce235f6f8fadeade8ae6b659250d827dacb49661d547d9f33890bae91a4ec08b274646149e5,
          exponent: 15313798138299520533890577607468214258928888911870549345522168491683238633588343642420845217348950357897417,
          len: 360)
      @prikey = RSAPrivateKey.new(
          p: 68673665721464068416235980858199544743687468414175557,
          q: 809180090317916969499569424473529102070680327018428449,
          exponent: 37801922716216207366067363960180605840741401288678166395972980898542220320045966295791798696007428382434425,
          len: 360)
    rescue
      nil
    end
  end

  it 'should encrypt and decrypt' do
    machine = RSAMachine.new(:pubkey => @pubkey, :prikey => @prikey)
    ctext = machine.encrypt(123)

    expect(machine.decrypt(ctext)).to eq(123)
  end

  it 'should block-encrypt and block-decrypt' do
    machine = RSAMachine.new(:pubkey => @pubkey, :prikey => @prikey)
    text = "Hello, World!"
    ptext = text.split('').collect { |c| c.ord}
    ctext = machine.block_encrypt ptext
    rtext = machine.block_decrypt(ctext).collect { |c| c.chr }.join

    expect(rtext).to eq(text)
  end
end