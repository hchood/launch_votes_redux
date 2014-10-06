require 'rails_helper'

feature "User adds a Launcher", %Q{
  As a user
  I want to add a Launcher
  So I can give them an award
  } do

  # Acceptance Criteria:
  # * I must specify a first name, last name and email.
  # * I can optionally provide a bio.
  # * Email must be unique.
  # * Bio must be at least 50 characters long.
  # * If the email is not unique, I receive an error message.

  before :each do
    visit root_path
    click_on "Add a Launcher"
  end

  scenario "with all required attributes" do
    launcher = FactoryGirl.build(:launcher)

    fill_in "First name", with: launcher.first_name
    fill_in "Last name", with: launcher.last_name
    fill_in "Email", with: launcher.email
    fill_in "Bio", with: launcher.bio
    click_on "Create Launcher"

    expect(page).to have_content "Success! The Launcher was added."
    expect(page).to have_content launcher.first_name
    expect(page).to have_content launcher.last_name
  end

  scenario "without all required attributes" do
    click_on "Create Launcher"

    expect(page).to have_content "Oh no! Launcher could not be saved."
    expect(page).to have_content "First name can't be blank"
    expect(page).to have_content "Last name can't be blank"
    expect(page).to have_content "Email can't be blank"
  end

  scenario "email already in use"

  scenario "bio is not long enough"

end
