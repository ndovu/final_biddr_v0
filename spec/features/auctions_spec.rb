require 'rails_helper'

RSpec.feature "Auctions", type: :feature do 
  describe "Home Page" do 
    it "displays a welcome message: 'Welcome to Biddr'" do
      visit root_path
      expect(page).to have_text "Welcome to Biddr!"
    end

    it "displays a title for the page" do
      visit root_path
      expect(page).to have_title "Biddr - better than ebay"
    end

    context "with Auctions created" do
      let!(:auction_1) { create(:auction) }
      let!(:auction_2) { create(:auction) }

      it "displays the title of the auction" do
        visit root_path
        expect(page).to have_text /#{auction_1.title}/i
      end

      it "displays auction titles in h2 elements" do
        visit root_path
        expect(page).to have_selector('h2', /#{auction_1.title}/i)
      end
    end

  end
end