require 'rails_helper'

describe User do
	it " is invalid when blank name" do
		user = User.new(
			name: "",
			email: "example@gmail.com",
		  password: "password",
		  password_confirmation: "password")
		expect(user).not_to be_valid
	end	


	it " is invalid when wrong password_confirmation" do
		user = User.new(
			name: "Ash",
			email: "example@gmail.com",
			password: "123456",
			password_confirmation: "654321")
		expect(user).not_to be_valid
		expect(user.errors[:password_confirmation]).to include("兩次輸入須一致")
	end
end

