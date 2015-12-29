$dev = true # flip this if running against an actually installed gem

if !$dev
  require 'bitster'
else
  require_relative '../lib/bitster/version'
  require_relative '../lib/bitster/crypto_math'
  require_relative '../lib/bitster/var_helpers'
  require_relative '../lib/bitster/rsa_key_pair'
  require_relative '../lib/bitster/rsa_pub_key'
  require_relative '../lib/bitster/rsa_private_key'
  require_relative '../lib/bitster/rsa_machine'
end

key_pair = Bitster::RSAKeyPair.new(:len => 1024).generate!
machine = Bitster::RSAMachine.new(:pubkey => key_pair.public_key,
                                  :prikey => key_pair.private_key)

ciphertext = %w(H E L L O).collect do |char|
  machine.encrypt(char.ord)
end

plaintext = ciphertext.collect do |ascii_code|
  machine.decrypt(ascii_code).chr
end.join('')

puts plaintext

