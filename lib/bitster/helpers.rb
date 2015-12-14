module Helpers

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
    [p-1, (p/1.5).round, (p/2.0).round, (p/3.0).round, 1].each do |a|
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
    max = 2**bits - 1
    r = rand(5..max)
    return r - 1 if r%2 == 0
    r
  end

  def gen_key(bits)
    lft = gen_odd(bits/2)
    rgt = gen_odd(bits/2)
    until probable_prime?(lft) do
      lft = gen_odd(bits/2)
    end

    until probable_prime?(rgt) do
      rgt = gen_odd(bits/2)
    end
    rgt * lft
  end
end
