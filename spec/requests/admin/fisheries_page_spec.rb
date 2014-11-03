describe "Manage fisheries page", :type => :request do

  context "there is a fishery to manage" do
    before(:each) do 
      @fishery = FactoryGirl.create(:fishery, name: "Stevo's Big trout fishery")
    end

    it "updates a fishery's details" do
      visit edit_admin_fishery_path @fishery.id
      expect(page.find_field('fishery_name').value).to eql "Stevo's Big trout fishery"

      fill_in "fishery_name", :with => "Dave's Big Trout Fishery"

      click_on 'Submit'

      expect(page).to have_content "Dave's Big Trout Fishery"
    end

    it "delete a fishery" do
      visit admin_fisheries_path
      click_on 'destroy'
      expect(page).not_to have_content "Stevo's Big trout fishery"
    end

    it "lists all fisheries" do
      visit admin_fisheries_path
      expect(page).to have_content "Stevo's Big trout fishery"
    end

    it "has a link to a fisheries waters" do
      visit admin_fisheries_path
      expect(page).to have_link 'show', href: admin_fishery_waters_path(@fishery)
    end

    it "has a button to add a water to a fishery" do
      visit admin_fisheries_path
      expect(page).to have_link 'add', href: new_admin_fishery_water_path(@fishery)
    end
  end

  context "there are no fisheries to manage" do

    it "has a lovely message telling you to create a fishery" do
      visit admin_fisheries_path
      expect(page).to have_content "There are no fisheries. Please add a fishery."
    end

    it "doesn't have a table of fisheries" do
      expect(page).to have_no_css 'table.waters'
    end


  end

end