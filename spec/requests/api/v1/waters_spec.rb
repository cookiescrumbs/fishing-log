describe Api::V1, type: :request do
  describe 'Waters' do
    before(:each) do
      # stub for when the fishery is created
      stub_google_geocode_address
      # stub for when the water is created
      stub_google_geocode_lat_lng

      species = FactoryBot.create :species
      water_type = FactoryBot.create :water_type
      @fishery = FactoryBot.create :fishery

      @params = {
        water: {
          name: 'loch blah blah',
          description: 'this is a loch description',
          latitude: Faker::Address.latitude,
          longitude: Faker::Address.longitude,
          water_type_id: water_type.id,
          species_ids: [species.id]
        }
      }
    end

    let(:latitude) { @params[:water][:latitude] }
    let(:longitude) { @params[:water][:longitude] }
    let(:water_name) { @params[:water][:name] }
    let(:water_description) { @params[:water][:description] }
    let(:fishery_slug) { @fishery.slug }
    let(:fishery_name) { @fishery.name }

    context 'request has required water parameter' do
      it 'POST /water/fishery/:slug' do

        post "/api/water/fishery/#{fishery_slug}", params: @params, headers: { 'Accept' => 'application/json' }

        expect(response).to be_successful
        expect(response.status).to eql 200
        expect(response.body).to include "Successfully added #{water_name} to #{fishery_name}"
        expect(response.body).to include(
          water_name,
          water_description,
          latitude.to_s,
          longitude.to_s
        )
      end
    end

    context 'request is missing some required water parameter' do
      it 'POST /water/fishery/#slug' do
        @params[:water][:name] = nil
        post "/api/water/fishery/#{fishery_slug}", params: @params, headers: { 'Accept' => 'application/json' }

        expect(response.status).to eql 500
        expect(response.body).to include 'error','waters','is invalid'
      end
    end
  end
end
