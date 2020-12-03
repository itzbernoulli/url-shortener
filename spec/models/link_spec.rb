require 'rails_helper'

RSpec.describe Link, type: :model do
  context 'validations' do
    it { should validate_presence_of(:url) }
    it { should validate_uniqueness_of(:slug) }
    it { should validate_length_of(:url) }
    it { should allow_values('http://foo.com', 'https://bar.com').for(:url)}
    it { should_not allow_values('foo.com', 'bar.com').for(:url)}
  end

  context 'slug generation' do
    describe '#generate_slug' do
      it 'should return a value when slug is absent' do
          link = build(:link, slug: nil)
          expect(link.generate_slug).to be_truthy
      end

      let(:link) { build(:link, slug: "feeble")  }
      
      it 'should return false when slug is present' do
        expect(link.generate_slug).to be_falsey
      end

      it 'should return slug value when slug value is present' do
          expect(link[:slug]).to eq("feeble")
      end
    end
  end

  

end
