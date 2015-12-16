#begin
  require_relative '../lib/bitster'
#rescue
 # require 'bitster'
#end

def enc(num, m, e)
  Bitster::CryptoMath::modular_pow(num, e, m)
end

def dec(cnum, m, e)
  Bitster::CryptoMath::modular_pow(cnum, e, m)
end

ciphertext = Array.new
result = Array.new

begin
  plaintext = File.read(ARGV[0]).split("")
rescue
  if $stdin.tty?
    plaintext = "HELLO_WORLD".split("")
  else
    plaintext = ARGF.read.split("")
  end
end

key_len = 4096
print "[*] Generating a new RSA key-pair with modulus #{key_len}..."
pair = Bitster::RSAKeyPair.new(key_len)
puts " done."

pubkey = pair.public_key
prikey = pair.private_key

print "[*] Encrypting..."
t0 = Time.now.to_i
plaintext.each do |c|
  ciphertext << enc(c.ord, pubkey.modulus, pubkey.exponent)
end
t1 = Time.now.to_i
puts " done; time elapsed: #{t1 - t0} seconds."


print "[*] Decrypting..."
t0 = Time.now.to_i
ciphertext.each do |c|
  result << (dec(c, prikey.modulus, prikey.exponent)).chr
end
t1 = Time.now.to_i
puts " done; time elapsed: #{t1 - t0} seconds."

puts "[*] Result:"
puts "-"*80
puts result.join
puts "-"*80
puts "[*] -END-"

