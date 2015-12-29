module Bitster

  # This class implements RSA encryption and decryption functions.
  # It is initialized with necessary keys, represented as instances
  # of their according classes.
  #
  class RSAMachine
    attr_accessor :pubkey, :prikey, :threads

    def initialize(opts={})
      options = init_defaults.merge(opts)
      @pubkey = options.fetch :pubkey
      @prikey = options.fetch :prikey
      @threads = options.fetch :threads
    end

    def init_defaults
      {threads: 8, pubkey: nil, prikey: nil}
    end
    # https://en.wikipedia.org/wiki/RSA_(cryptosystem)#Encryption
    #
    def encrypt(plaintext_msg_code)
      modular_pow(plaintext_msg_code, pubkey.exponent, pubkey.modulus)
    end

    # https://en.wikipedia.org/wiki/RSA_(cryptosystem)#Decryption
    #
    def decrypt(ciphertext_msg_code)
      modular_pow(ciphertext_msg_code, prikey.exponent, prikey.modulus)
    end

    def block_encrypt(plaintext)
      plaintext.collect { |code| encrypt code }
    end

    def block_decrypt(ciphertext)
      ciphertext.collect { |code| decrypt code }
    end

    def work_mt(input, operation="")
      slice_len = (input.length/threads.to_f).ceil
      output = []
      result = []
      threads = []
      i = 0
      input.each_slice(slice_len) do |slice|
        threads << Thread.new(i) { |t_num|
          case operation
            when /dec/
              output[t_num] = block_decrypt(slice)
            when /enc/
              output[t_num] = block_encrypt(slice)
            else
              raise "Operation not recognized!"
          end
        }
        i += 1
      end
      threads.each {|t| t.join }

      output.each do |row|
        row.each do |col|
          result << col
        end
      end

      result
    end

    def block_decrypt_mt(ciphertext)
      work_mt(ciphertext, 'dec')
    end

    def block_encrypt_mt(plaintext)
      work_mt(plaintext, 'enc')
    end

    def block_decrypt_mt_(ciphertext)
      slice_len = (ciphertext.length/threads.to_f).ceil
      ptext = []
      result = []
      threads = []
      i = 0
      ciphertext.each_slice(slice_len) do |slice|
        threads << Thread.new(i) { |t_num|
          ptext[t_num] = block_decrypt(slice)
        }
        i += 1
      end
      threads.each {|t| t.join }

      ptext.each do |row|
        row.each do |col|
          result << col
        end
      end

      result
    end

    def block_encrypt_mt_(plaintext)
      slice_len = (plaintext.length/threads.to_f).ceil
      ctext = []
      result = []
      threads = []
      i = 0
      plaintext.each_slice(slice_len) do |slice|
        threads << Thread.new(i) { |t_num|
          ctext[t_num] = block_encrypt(slice)
        }
        i += 1
      end
      threads.each {|t| t.join }

      ctext.each do |row|
        row.each do |col|
          result << col
        end
      end

      result
    end

    private
    include CryptoMath

  end
end
