require 'bitster/version'
require 'bitster/crypto_math'
require 'bitster/var_helpers'
require 'bitster/rsa_key_pair'
require 'bitster/rsa_pub_key'
require 'bitster/rsa_private_key'

require 'json'

module Bitster
  include self::CryptoMath
end