module Bitster

  # This class represents a RSA key-pair. The most important feature is the
  # generation of the key-pair, so it is an implementation of the process
  # outlined in https://en.wikipedia.org/wiki/RSA_(cryptosystem)#Key_generation
  #
  class RSAKeyPair

    class RSAKeyPairError < StandardError
    end

    attr_reader :len, :shorter, :p, :q, :n, :k, :e, :private_key, :public_key

    def initialize(len)
      @len = len

      @shorter = rand(0..1)
      #@p = gen_p
      #@q = gen_q
      @p, @q = gen_pq
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
    def gen_pq
        #handle_exceptions do
          len = @len/2
          len_p = len_q = len
          len_q = len - rand(2..4) if @shorter == 1
          len_p = len - rand(2..4) if @shorter == 0
          p=q=0
          loop do
            q = gen_odd(len_q)
            break if probable_prime?(q)
          end
          loop do
            p = gen_odd(len_p)
            break if probable_prime?(p)
          end
          return p, q
        #end
    end

    def gen_totient
      handle_exceptions do
        (@p-1)*(@q-1)
      end
    end

    # ToDo: what should the lower bound really be?
    def gen_e
      handle_exceptions do
        loop do
          e = rand(4..@k)
          return e if e.gcd(@k) == 1
        end
      end
    end

    def gen_d
      handle_exceptions do
        modular_multiplicative_inverse(e, k)
      end
    end

    def handle_exceptions
      begin
        yield
      rescue StandardError => e
        raise RSAKeyPairError, "Exception in RSAKeyPair: #{e}"
      end
    end
  end
end
