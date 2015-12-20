module Bitster
  module CryptoMath

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

    def probable_prime?(p, k=7)
      fermat_prime?(p) && rm_prime?(p, k)
    end

    def fermat_prime?(p)
      raise ArgumentError, 'Argument must be an Integer greater than 3' unless p.is_a?(Integer) && (p>3)
      [p-1, p/2, p/3, p/4, 1].each do |a|
        # return false if (a**(p-1) % p) != (1 % p)
        return false if modular_pow(a, (p-1), p) != (1 % p)
      end
      true
    end

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

    def gen_odd(bits)
      max = 2**bits
      min = 2**(bits-1)
      r = rand(min..max)
      return r - 1 if r%2 == 0
      r
    end

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
      if r > 1
        raise StandardError, "#{a} and #{n} are not coprimes, can't find MMI"
      end
      if t < 0
        t += n
      end
      t
    end
    
    extend self

  end
end
