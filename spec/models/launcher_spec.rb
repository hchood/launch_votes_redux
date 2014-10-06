require 'rails_helper'

RSpec.describe Launcher, :type => :model do
  let!(:launcher) { FactoryGirl.create(:launcher) }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }

  it { should have_valid(:bio).when("Best private detective in all the land. - Lucille B.", nil, "") }
  it { should_not have_valid(:bio).when("some short string") }
end
