require 'rails_helper' 

describe Project do
  before { @project = FactoryGirl.build(:project) }
  subject { @project }

  it { should respond_to(:title) }
  it { should respond_to(:notes) }
  it { should respond_to(:thumbnail) }
  it { should respond_to(:contents) }
  it { should respond_to(:is_public) }
  it { should respond_to(:last_modified) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }

  it { should be_valid }

  #it { should validate_presence_of(:id) }
  #it { should validate_uniqueness_of(:id) }
  #it { should validate_presence_of(:created_at) }
  #it { should validate_presence_of(:updated_at) }

  it { should allow_value('example_title').for(:title) }
  it { should allow_value('example_note').for(:notes) }
  it { should allow_value('example_content').for(:contents) }
  it { should allow_value(1).for(:is_public) }
  it { should allow_value(0).for(:is_public) }
end
