module Bitster
  module VarHelpers
    include Math

    def pad(num, base, len)
      digits = (len*log(2)) / (log(base))
      num.to_s(base).rjust(digits, '0')
    end

    extend self

  end
end
