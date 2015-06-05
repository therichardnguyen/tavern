require 'spec_helper'

describe User do
  describe "validations" do
    it "should require an :email" do
      expect(FactoryGirl.build(:user, email: "")).to_not be_valid
    end
    
    it "should require a :password_digest" do
      expect(FactoryGirl.build(:user, password_digest: "")).to_not be_valid
    end
  end
  
  describe "setting password" do
    it "matching password and confirmation should create a :password_digest" do
      expect(FactoryGirl.build(:user, password:"password", password_confirmation:"password")).to be_valid
    end
    
    it "mismatched password and confirmation should not create a :password_digest" do
      expect(FactoryGirl.build(:user, password:"password", password_confirmation:"does not match")).to_not be_valid
    end
  end
end