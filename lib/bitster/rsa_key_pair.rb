module Bitster

  # This class represents a RSA key-pair. The most important feature is the
  # generation of the key-pair, so it is an implementation of the process
  # outlined in https://en.wikipedia.org/wiki/RSA_(cryptosystem)#Key_generation
  #
  class RSAKeyPair

    attr_reader :len, :shorter, :p, :q, :n, :k, :e, :private_key, :public_key

    def initialize(len)
      @len = len

      @shorter = rand(0..1)
      @p = gen_p
      @q = gen_q
      @n = @p * @q # modulus
      @k = gen_totient
      @e = gen_e # pubkey exponent
      @d = gen_d # prikey exponent

      @private_key = RSAPrivateKey.new(@p, @q, @d, @len)
      @public_key = RSAPubKey.new(@n, @e, @len)

    end


    private
    include CryptoMath

    # ToDo: what should the length difference of p and q really be?
    def gen_p
      len_p = @len/2
      len_p -= rand(2..4) if @shorter == 0
      loop do
        p = gen_odd(len_p)
        return p if probable_prime?(p)
      end
    end

    # ToDo: what should the length difference of p and q really be?
    def gen_q
      len_q = @len/2
      len_q -= rand(2..4) if @shorter == 1
      loop do
        q = gen_odd(len_q)
        return q if probable_prime?(q)
      end
    end

    def gen_totient
      (@p-1)*(@q-1)
    end

    # ToDo: what should the lower bound really be?
    def gen_e
      loop do
        e = rand(4..@k)
        return e if e.gcd(@k) == 1
      end
    end

    def gen_d
      modular_multiplicative_inverse(e, k)
    end
  end
end
