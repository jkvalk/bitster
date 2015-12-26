module Bitster

  # This module implements mathematical functions needed by the RSA layer,
  # i.e. primality tests, modular arithmetic, and random odd number generation.
  #
  # ToDo: Error handling (with custom Exception class, etc.)
  #
  module CryptoMath

    # This function performs what is known as Modular exponentiation
    # https://en.wikipedia.org/wiki/Modular_exponentiation
    #
    # Modular exponentiation are easy to compute, even when the numbers
    # involved are enormous.
    #
    def modular_pow(base, exponent, modulus)
      return nil if modulus == 1
      result = 1
      base = base % modulus
      while exponent > 0 do
        if (exponent % 2) == 1
          result = (result * base) % modulus
        end
        exponent = exponent >> 1
        base = (base * base) % modulus
      end
      result
    end

    # This function just combines Fermat test and Rabin-Miller test.
    # If both witness the primality, we consider the argument a
    # probable prime
    #
    # ToDo: How to calculate an optimal number of RM rounds instead of 7?
    #
    def probable_prime?(p, k=7)
      fermat_prime?(p) && rm_prime?(p, k)
    end

    # This is Fermat primality test.
    # https://en.wikipedia.org/wiki/Fermat_primality_test
    #
    # ToDo: How to really choose "a" and how many iterations to run?
    #
    def fermat_prime?(p)
      raise ArgumentError, 'Argument must be an Integer greater than 3' unless p.is_a?(Integer) && (p>3)
      [p-1, p/2, p/3, p/4, 1].each do |a|
        # return false if (a**(p-1) % p) != (1 % p)
        return false if modular_pow(a, (p-1), p) != (1 % p)
      end
      true
    end

    # This is Rabin-Miller primality test
    # https://en.wikipedia.org/wiki/Miller%E2%80%93Rabin_primality_test
    #
=begin
    def rm_prime?(n, k)
      r=0; d=0
      (1..128).each do |i|
        d = n / (2**i)
        r = i
        break unless (d % 2) == 0
      end
      k.times do
        flg = false
        a = rand(2..(n-2))
        x = modular_pow(a, d, n)
        if (x == 1) || (x == (n - 1))
          next
        end
        (r-1).times do
          x = modular_pow(x, 2, n)
          return false if x == 1
          if x == (n - 1)
            flg = true
            break
          end
        end
        next if flg
        return false
      end
      true
    end
=end

    def rm_prime?(n, k)
      r = 0
      d = 0
      (1..128).each do |i|
        d = n / (2**i)
        r = i
        break unless d.even?
      end
      rm_witness_loop(k, n, d, r)
    end

    def rm_witness_loop(k, n, d, r)
      k.times do
        a = rand(2..(n - 2))
        x = modular_pow(a, d, n)

        next if x == 1 || x == (n - 1)
        next if rm_inner_witness_loop(x, n, r)
        return false
      end
      true
    end

    def rm_inner_witness_loop(x, n, r)
      (r - 1).times do
        x = modular_pow(x, 2, n)
        return false if x == 1
        return true if x == (n - 1)
      end
      false
    end

    # This function generates a random odd integer in a range of
    # 2^(bits-1) ... 2^(bits)
    #
    # ToDo: What should the minimum really be?
    #
    def gen_odd(bits)
      max = 2**bits
      min = 2**(bits-1)
      r = rand(min..max)
      return r - 1 if r%2 == 0
      r
    end

    # This function calculates the Modular multiplicative inverse
    # which is needed in the key generation process.
    # https://en.wikipedia.org/wiki/Modular_multiplicative_inverse
    #
    def modular_multiplicative_inverse(a, n)
      t = 0
      nt = 1
      r = n
      nr = a % n
      if n < 0
        n = -n
      end
      if a < 0
        a = n - (-a % n)
      end
      while nr != 0 do
        quot = 0
        quot = (r/nr) unless (r/nr) == 0
        tmp = nt; nt = t - quot*nt; t = tmp
        tmp = nr; nr = r - quot*nr; r = tmp
      end
      raise StandardError,
            "#{a} and #{n} are not coprimes, can't find MMI" if r > 1
      t += n if t < 0
      t
    end
    
    extend self

  end
end
