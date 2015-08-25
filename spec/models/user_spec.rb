require 'rails_helper'

describe User do
	it " is invalid with blank name" do
		user = User.new(
			name: "",
			email: "example@gmail.com",
		  password: "password",
		  password_confirmation: "password")
		user.valid?
		expect(user).not_to be_valid
	end	


	it " is invalid with wrong password_confirmation" do
		user = User.new(
			name: "Ash",
			email: "example@gmail.com",
			password: "123456",
			password_confirmation: "654321")
		user.valid?
		expect(user).not_to be_valid
		expect(user.errors[:password_confirmation]).to include("兩次輸入須一致")
	end

	it "is invalid with duplicate email" do
		User.create(
			name: "Ash",
			email: "example@gmail.com",
			password: "123456",
			password_confirmation: "123456")

		user = User.create(
			name: "Vi",
			email: "example@gmail.com",
			password: "123456",
			password_confirmation: "123456")

	
		expect(user.errors[:email]).to include("已被使用")
	end
end

