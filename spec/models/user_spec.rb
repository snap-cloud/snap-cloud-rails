require 'spec_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }
end


# Can Be Cleaned Up if we want:
# http://apionrails.icalialabs.com/book/chapter_three#code-long_validating_email
describe "when email is not present" do
  before { @user.email = " " }
  it { should_not be_valid }
end