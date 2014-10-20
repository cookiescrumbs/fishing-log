describe "Manage fisheries page", :type => :request do

    before(:each) do 
      @fishery = FactoryGirl.create(:fishery, name: "Stevo's Big trout fishery")
    end

    it "Updates a fishery's details" do
      visit edit_admin_fishery_path @fishery.id
      expect(page.find_field('fishery_name').value).to eql "Stevo's Big trout fishery"

      fill_in "fishery_name", :with => "Dave's Big Trout Fishery"

      click_on 'Submit'

      expect(page).to have_content "Dave's Big Trout Fishery"
    end

    it "Delete a fishery" do
      visit admin_fisheries_path
      click_on 'destroy'
      expect(page).not_to have_content "Stevo's Big trout fishery"
    end

    it "lists all fisheries" do
      visit admin_fisheries_path
      expect(page).to have_content "Stevo's Big trout fishery"
    end

end