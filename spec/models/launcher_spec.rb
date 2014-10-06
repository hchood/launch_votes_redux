require 'rails_helper'

RSpec.describe Launcher, :type => :model do
  let!(:launcher) { FactoryGirl.create(:launcher) }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should ensure_length_of(:bio).is_at_least(50) }
end
