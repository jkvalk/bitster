module Bitster

  # This class represents RSA public key and provides various
  # formatting and similar helper methods associated with it.
  #
  class RSAPubKey

    attr_reader :modulus, :exponent, :len

    def initialize(opts={})
      options = init_defaults.merge(opts)
      @modulus = options.fetch :modulus
      @exponent = options.fetch :exponent
      @len = options.fetch :len
    end

    def init_defaults
      {modulus: nil, exponent: nil, len: nil}
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
