$dev = true

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

ciphertext = Array.new
result = Array.new

begin
  plaintext = File.read(ARGV[0]).split("")
rescue
  if $stdin.tty?
    plaintext = ("C"*32).split("")
  else
    plaintext = ARGF.read.split("")
  end
end

key_len = 1024
print "[*] Generating a new RSA key-pair with modulus #{key_len}..."
t0 = Time.now.to_i
pair = Bitster::RSAKeyPair.new(key_len)
t1 = Time.now.to_i
puts " done; time elapsed: #{t1 - t0}s."

machine = Bitster::RSAMachine.new(:keypair => pair)

print "[*] Encrypting..."
t0 = Time.now.to_i
plaintext.each do |c|
  ciphertext << machine.encrypt(c.ord)
end
t1 = Time.now.to_i
puts " done; time elapsed: #{t1 - t0}s."


print "[*] Decrypting..."
t0 = Time.now.to_i
ciphertext.each do |c|
  result << machine.decrypt(c).chr
end
t1 = Time.now.to_i
puts " done; time elapsed: #{t1 - t0}s."

puts "[*] Result:"
puts "-"*80
puts result.join
puts "-"*80
puts "[*] -END-"
