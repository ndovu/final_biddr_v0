require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  let(:user) { create(:user) }

  describe "signing in" do
    it "redirects the user to the home page" do
      visit new_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Logged in! Welcome.")
    end
  end
end