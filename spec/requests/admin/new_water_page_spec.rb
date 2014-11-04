describe "New water page", type: :request do
  
  before :each do
    @fishery = FactoryGirl.create :fishery, name: "Bob's big fishery"
    @species = FactoryGirl.create_list :species, 5

    visit new_admin_fishery_water_path @fishery.id
  end

  it "has the name of the fishery" do
    expect(page).to have_content "New water for Bob's big fishery"
  end 

  context "form is filled out correctly" do

    it "adds a water to a fishery, shows the water's details and says a nice thing" do

      fill_in 'water_name', with: "Total Loch Doon"
      fill_in 'water_latitude', with: -90
      fill_in 'water_longitude', with: -180
      check @species.first.name
      check @species.last.name

      click_on "Submit"

      expect(page).to have_content "Total Loch Doon"
      save_page
      expect(page).to have_content @species.first.name + ', ' + @species.last.name
      expect(page.find('.alert')).to have_content "#{@fishery.waters.last.name} was successfully added to #{@fishery.name}"
    end

  end

  context "form is filled out incorrectly" do

    it "shows a helpful validation messages for required fields" do
      fill_in 'water_name',       with: ''
      fill_in 'water_latitude',   with: ''
      fill_in 'water_longitude',  with: ''
      
      click_on "Submit"

      expect(page.find('.alert')).to have_content "3 errors prohibited this water from being saved: Name can't be blank Latitude is not a number Longitude is not a number"
    end




  end
end