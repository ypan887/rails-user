require 'rails_helper'

RSpec.describe "User", type: :feature do

  describe "login" do
    it "display login page" do
      visit signin_path
      expect(page).to have_selector('input', value: 'Sign in')
    end

    describe "with correct information" do
      let(:user) { FactoryGirl.create(:user) }

      it "signs me in and redirect to profile page" do
        visit signin_path
        within("form#new_user") do
          fill_in 'user[email]', with: user.email
          fill_in 'user[password]', with: user.password
        end
        click_button 'Sign in'
        expect(page).to have_http_status(:ok)
        expect(page).to have_selector('alert alert-success', text: "welcome")
        expect(page).to have_link("Logout", href: signout_path)
      end
    end

    describe "with invalid information" do
      it "display error message" do
        visit signin_path
        click_button 'Sign in'
        expect(page).to have_selector('alert alert-danger', text: "alert")
      end
    end
  end

  describe "signup process" do
    it "display signup page" do
      visit signup_path
      expect(page).to have_selector('input', value: "Start Analyzing »")
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.build(:user) }
      before do
        visit signup_path

        within("form#new_user") do
          fill_in 'user[first_name]', with: user.first_name
          fill_in 'user[last_name]', with: user.last_name
          fill_in 'user[email]', with: user.email
          fill_in 'phone1', with: 415
          fill_in 'phone2', with: 555
          fill_in 'phone3', with: 1234
          fill_in 'user[password]', with: user.password
          fill_in 'user[password_confirmation]', with: user.password_confirmation
        end
      end

      it "create a new user" do
        expect(click_button("Start Analyzing »")).to change(User, :count).by(1)
      end
      
      it "redirect to welcome page with message" do
        click_button("Start Analyzing »")
        expect(page).to have_http_status(:success)
        expect(page).to have_selector('alert alert-success', text: "welcome")
        expect(page).to have_link("Logout", href: signout_path)
        expect(page).to_not have_link("Log in", href: signin_path)
      end
    end

    describe "with invalid information" do
      it "display error message" do
        visit signup_path
        click_button 'Start Analyzing »'
        expect(page).to have_selector('alert alert-danger', text: "alert")
      end
    end
  end

  describe "signout process" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      visit signin_path
      within("form#new_user") do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
      end
      click_button "Sign in"
    end
    
    it "signout user" do
      click_link("Logout")
      expect(page).to_not have_link("Logout", href: signout_path)
      expect(page).to have_link("Log in", href: signin_path)
    end
  end
end