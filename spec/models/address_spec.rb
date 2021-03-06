describe Address, type: :model do
  before do
    stub_google_geocode_address
    @address = FactoryBot.create(:address)
  end

  describe 'formatted address' do
    it 'returns a formatted address' do
      expect(@address.formatted).to eql "#{@address.street}, #{@address.line2}, #{@address.region}, #{@address.postcode}, #{@address.country}"
    end

    it 'returns a formatted address exluding missing parts' do
      @address.line2 = nil
      @address.region = ''
      expect(@address.formatted).to eql "#{@address.street}, #{@address.postcode}, #{@address.country}"
    end
  end
end
