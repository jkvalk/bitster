module Bitster

  # This class implements RSA encryption and decryption functions.
  # It is initialized with necessary keys, represented as instances
  # of their according classes.
  #
  class RSAMachine
    attr_accessor :pubkey, :prikey

    def initialize(opts={})
      @pubkey = opts[:pubkey] if opts.has_key?(:pubkey)
      @prikey = opts[:prikey] if opts.has_key?(:prikey)
      if opts.has_key?(:keypair)
        @pubkey = opts[:keypair].public_key
        @prikey = opts[:keypair].private_key
      end
    end

    # https://en.wikipedia.org/wiki/RSA_(cryptosystem)#Encryption
    #
    def encrypt(plaintext_msg_code)
      CryptoMath::modular_pow(plaintext_msg_code, @pubkey.exponent, @pubkey.modulus)
    end

    # https://en.wikipedia.org/wiki/RSA_(cryptosystem)#Decryption
    #
    def decrypt(ciphertext_msg_code)
      CryptoMath::modular_pow(ciphertext_msg_code, @prikey.exponent, @prikey.modulus)
    end

  end
end
