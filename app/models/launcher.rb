class Launcher < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email,
    presence: true,
    uniqueness: true
  validates :bio, length: { minimum: 50 }, allow_blank: true
end
