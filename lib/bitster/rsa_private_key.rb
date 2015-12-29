module Bitster

  # This class represents RSA private key and provides various
  # formatting and similar helper methods associated with it.
  #
  class RSAPrivateKey

    attr_reader :modulus, :exponent, :len, :p, :q

    def initialize(opts={})
      options = init_defaults.merge(opts)
      @exponent = options.fetch :exponent
      @p = options.fetch :p
      @q = options.fetch :q
      @modulus = @p * @q
      @len = options.fetch :len
    end

    def init_defaults
      { p: nil, q: nil, exponent: nil, len: nil }
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


