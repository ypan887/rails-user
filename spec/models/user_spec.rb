require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when create user' do
    let(:user) { User.new(first_name: "User", last_name: "1", 
      email: "user_1@example.com", password: "password", password_confirmation: "password") }
    let(:another_user) { user.dup }

    specify { expect(user).to respond_to(:first_name) }
    specify { expect(user).to respond_to(:last_name) }
    specify { expect(user).to respond_to(:email) }
    specify { expect(user).to respond_to(:password_digest) }
    specify { expect(user).to respond_to(:password) }
    specify { expect(user).to respond_to(:password_confirmation) }
    specify { expect(user).to respond_to(:phone_number) }

    specify { expect(user).to be_valid }

    specify "validate presence of first name" do
      user.first_name = ""
      expect(user).to_not be_valid 
    end

    specify "validate presence of last name" do
      user.last_name = ""
      expect(user).to_not be_valid 
    end

    specify "validate presence of email" do
      user.email = ""
      expect(user).to_not be_valid 
    end

    specify "validate presence of phone number" do
      user.phone_number = ""
      expect(user).to_not be_valid 
    end

    specify "validate length of first name" do
      user.first_name = "a" * 51
      expect(user).to_not be_valid 
    end

    specify "validate length of last name" do
      user.last_name = "a" * 51
      expect(user).to_not be_valid 
    end

    specify "validate email format" do
      user.email = "invalid email"
      expect(user).to_not be_valid 
    end

    specify "validate email uniqueness" do
      user.save
      expect(another_user).to_not be_valid 
    end

    specify "validate presence of password" do
      user.password = ""
      user.password_confirmation = ""
      expect(user).to_not be_valid 
    end

    specify "validate password and confirmation is matching" do
      user.password_confirmation = "mismatch"
      expect(user).to_not be_valid 
    end

    specify "validate presence of password confirmation" do
      user.password_confirmation = nil
      expect(user).to_not be_valid 
    end

    specify "validate password length" do
      user.password = user.password_confirmation = "a" * 5
      expect(user).to_not be_valid 
    end
  end

  context "when authenticate user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:found_user) { User.find_by_email(user.email) }
    let(:user_with_invalid_password) { found_user.authenticate("invalid") }

    specify "with valid password" do
      expect(found_user).to eq(found_user.authenticate(user.password)) 
    end

    specify "with invalid password" do
      expect(found_user).to_not eq(user_with_invalid_password) 
      expect(user_with_invalid_password).to be_falsey
    end
  end
end