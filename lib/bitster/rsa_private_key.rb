module Bitster

  # This class represents RSA private key and provides various
  # formatting and similar helper methods associated with it.
  #
  class RSAPrivateKey

    attr_reader :modulus, :exponent, :len, :p, :q

    def initialize(p, q, exponent, len)
      @exponent = exponent
      @modulus = p*q
      @p = p; @q = q
      @len = len
    end

    def get_hash
      { modulus: pad(modulus, 16, len), exponent: pad(exponent, 16, len) }
    end

    def get_json
      JSON.pretty_generate get_hash
    end

    private
    include VarHelpers

  end
end


