require 'rails_helper'

RSpec.describe Link, type: :model do
  context 'validations' do
    it { should validate_presence_of(:url) }
    it { should validate_uniqueness_of(:slug) }
    it { should validate_length_of(:url) }
    it { should allow_values('http://foo.com', 'https://bar.com').for(:url)}
    it { should_not allow_values('foo.com', 'bar.com').for(:url)}
  end

end
