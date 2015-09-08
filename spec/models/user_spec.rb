require 'rails_helper'

describe User do
	it "has a valid factory" do
		expect(build(:user)).to be_valid
	end	
end

describe User do
	it " is invalid with blank name" do
		user = build(:user, name: "")
		user.valid?
		expect(user).not_to be_valid
	end	


	it " is invalid with wrong password_confirmation" do
		user = build(:user, password_confirmation: "123457")
		user.valid?
		expect(user).not_to be_valid
		expect(user.errors[:password_confirmation]).to include("兩次輸入須一致")
	end

	it "is invalid with duplicate email" do
		
		create(:user, email: "errol@email.com")

		user = build(:user, email: "errol@email.com")
		
		expect(user).not_to be_valid
	end
end

