describe 'CryptoMath' do

  before do
    @repeat = 1
  end

  it 'should calculate modular pow' do
    expect(modular_pow(3, 2, 2)).to eq(1)
    expect(modular_pow(2, 9, 3)).to eq(2)
    expect(modular_pow(4, 7, 7)).to eq(4)
  end

  it 'should generate odd' do
    @repeat.times do
      [16, 32, 48, 56, 64, 128, 192, 256, 512].each do |i|
        # ToDo: test for real ranges
        expect(gen_odd(i)).to satisfy { |v| v >= 3 }
        expect(gen_odd(i)).to satisfy { |v| (v%2) == 1 }
        expect(gen_odd(i)).to satisfy { |v| v <= 2**i }
      end
    end
  end

  it 'should perform fermat test' do
    [104677, 104681, 104683, 104693, 104701, 104707, 104711, 104717, 104723, 104729].each do |p|
      expect(fermat_prime?(p)).to eq(true)
    end
    [104679, 104685, 104687, 104695, 104703, 104705, 104713, 104719, 104725, 104727].each do |p|
      expect(fermat_prime?(p)).to eq(false)
    end
  end

  it 'should perform rabin-miller test' do
    [104677, 104681, 104683, 104693, 104701, 104707, 104711, 104717, 104723, 104729].each do |p|
      expect(rm_prime?(p, rand(5..50))).to eq(true)
    end
    [104679, 104685, 104687, 104695, 104703, 104705, 104709, 104719, 104721, 104725].each do |p|
      expect(rm_prime?(p, rand(5..50))).to eq(false)
    end
  end

  it 'should perform probable prime test' do
    [104677, 104681, 104683, 104693, 104701, 104707, 104711, 104717, 104723, 104729].each do |p|
      expect(probable_prime?(p)).to eq(true)
    end
    [104679, 104685, 104687, 104695, 104703, 104705, 104709, 104719, 104721, 104725].each do |p|
      expect(probable_prime?(p)).to eq(false)
    end
  end


end