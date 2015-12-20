# Bitster
Bitster is an educational/experimental/fun RSA public/asym key cryptography implementation in Ruby. To become a really cool toy, 
a custom AES engine and some multithreading should be added.

## Usage
```ruby
require 'bitster'

key_pair = Bitster::RSAKeyPair.new(1024)
machine = Bitster::RSAMachine.new(:keypair => key_pair)
ciphertext = Array.new

%w(H E L L O).each do |char|
  ciphertext << machine.encrypt(char.ord)
end

ciphertext.each do |ascii_code|
  print (machine.decrypt(ascii_code)).chr
end
```
