module Bitster

  # This class represents RSA public key and provides various
  # formatting and similar helper methods associated with it.
  #
  class RSAPubKey

    attr_reader :modulus, :exponent, :len

    def initialize(modulus, exponent, len)
      @modulus = modulus
      @exponent = exponent
      @len = len
    end

    def get_hash
      { modulus: pad(@modulus, 16, @len), exponent: pad(@exponent, 16, @len) }
    end

    def get_json
      JSON.pretty_generate get_hash
    end

    private
    include VarHelpers

  end
end
