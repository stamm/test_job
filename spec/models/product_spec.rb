require 'spec_helper'

describe Product do
  context 'validation' do
    describe 'valid' do
      it { expect(build(:product)).to be_valid }
    end
    describe 'not valid' do
      context '#title' do
        it { expect(build(:product, title: '')).to_not be_valid }
      end
      context '#price' do
        it { expect(build(:product, price: -1)).to_not be_valid }
        it { expect(build(:product, price: 0)).to_not be_valid }
        it { expect(build(:product, price: '')).to_not be_valid }
        it { expect(build(:product, price: 'a')).to_not be_valid }
      end
    end
  end
end
