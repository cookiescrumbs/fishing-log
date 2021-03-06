require_relative '../features_helper'

describe 'New water page', type: :feature do
  before :each do
    stub_google_geocode_lat_lng
    stub_google_geocode_address

    @fishery_manager = FactoryBot.create :user, email: 'fishery_manager@fishery.com', password: '5lbBr0wnTr0ut', auth: Rails.application.config.fishery_manager

    sign_in @fishery_manager

    visit your_fishery_path
    page.all('.add-water').first.click
  end

  let(:fishery) { @fishery_manager.fisheries.last }

  it 'has the name of the fishery' do
    expect(page).to have_content "Adding a new water to #{fishery.name}"
  end

  context 'form is filled out correctly' do
    it "adds a water to a fishery, shows the water's details and says a nice thing" do
      fill_in 'water_name', with: 'Total Loch Doon'
      fill_in 'water_permission_tickets', with: 'Get tickets from Pete. You\'ll be able to find him. Follow the pistachio shells.'
      # had to use find as the fields are hidden
      find('#latitude').set(-90)
      find('#longitude').set(-180)
      check Species.first.name.capitalize
      choose WaterType.first.category.capitalize
      attach_file('water_images_attributes_0_image', File.join(Rails.root, 'spec/fixtures/files/another-loch.jpg'))
      attach_file('water_images_attributes_1_image', File.join(Rails.root, 'spec/fixtures/files/another-loch.jpg'))
      check 'water_images_attributes_0_hero'


      click_on 'Submit water details'

      new_water = fishery.waters.find_by name: 'Total Loch Doon'

      expect(page).to have_content 'Total Loch Doon'
      expect(page.find('.alert')).to have_content "Total Loch Doon was successfully added to #{fishery.name}"
      expect(new_water.permission_tickets).to eql 'Get tickets from Pete. You\'ll be able to find him. Follow the pistachio shells.'
      expect(new_water.images.first.image_file_name).to eql 'another-loch.jpg'
      expect(new_water.images.first.hero).to eql true
      expect(new_water.images.last.hero).to eql false
    end
  end

  context 'form is filled out incorrectly' do
    it 'shows a helpful validation messages for required fields' do
      fill_in 'water_name', with: ''
      # had to use find as the fields are hidden
      find('#latitude').set(-90)
      find('#longitude').set(-180)
      click_on 'Submit'

      message = '3 errors prohibited this water from being saved:'\
      " Water name can't be blank You need to select"\
      ' at least one fish species You need to select a water type'

      expect(page.find('.alert')).to have_content message
    end
  end
end
