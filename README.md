### Overview

Below is an overview of git and TDD workflow to use in your Breakable Toys.

### App overview

#### ER Diagram

![er_diagram](https://s3-us-west-2.amazonaws.com/flightops.launchacademy.com/launch_votes_redux.png)


#### User Stories

```no-highlight
As a user
I want to add a Launcher
So I can give them an award
```

```no-highlight
As a user
I want to add an award
So I can give it to a Launcher
```

### Workflow overview

For "user adds a Launcher" user story

1. **Checkout a feature branch.** (First make sure you have the most recent version of master.)

  ```no-highlight
  git checkout master && git pull origin master
  git checkout -b add-launcher
  ```

2. **Write acceptance test.** I add pending tests for all the specs I plan to write (enough to cover all my acceptance criteria) and just write out the happy path test to start.  Once I get the happy path test passing, I'll write out the next pending test.

  ```ruby
  # spec/features/user_adds_a_launcher_spec.rb
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

    scenario "with all attributes" do
      visit root_path
      click_on "Add a Launcher"

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

    scenario "without all required attributes"

    scenario "without bio"

    scenario "email already in use"

    scenario "bio is not long enough"
  end
  ```

3. **Proceed with implementation to make acceptance test pass, until get `uninitialized constant Launcher` error.** To get past this error, I'll need to build a model.  Before I build my model, I need to write unit tests for that model to help drive the development of my model.

4. **Write unit tests.** Use `valid_attribute` or `shoulda` gems to test validations and associations.

  ```ruby
  # spec/models/launcher_spec.rb
  require 'rails_helper'

  RSpec.describe Launcher, :type => :model do
    # need to create a Launcher object for uniqueness validation test to pass
    let!(:launcher) { FactoryGirl.create(:launcher) }

    # tests using shoulda gem
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }

    # tests using valid_attribute gems
    it { should have_valid(:bio).when("Best private detective in all the land. - Lucille B.", nil, "") }
    it { should_not have_valid(:bio).when("some short string") }

    # when we add the Award model, we'll add a test for the association as well:
    # it { should have_many :awards }
  end
  ```

5. **Make unit tests pass.**

  ```ruby
  class Launcher < ActiveRecord::Base
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email,
      presence: true,
      uniqueness: true
    validates :bio, length: { minimum: 50 }, allow_blank: true
  end
  ```

6. **Proceed with making acceptance test pass.**

7. **Refactor!** Review my tests and code I've written to see where things can be made more readable, DRYer, etc.s

8. **Write out the next pending test, add code to make it pass, and continue until all pending tests have been implemented and are passing.**

  ```ruby
  # spec/features/user_adds_a_launcher_spec.rb

  scenario "without all required attributes" do
    visit root_path
    click_on "Add a Launcher"

    click_on "Create Launcher"

    expect(page).to have_content "Oh no! Launcher could not be saved."
    expect(page).to have_content "First name can't be blank"
    expect(page).to have_content "Last name can't be blank"
    expect(page).to have_content "Email can't be blank"
  end
  ```

9. **Test out the feature in the browser.** If you encounter errors, add a test for that scenario and make the test pass.

10. **Create a Pull Request.**

  ```no-highlight
  git push origin add-launcher
  ```

  On GitHub, click the "Compare and Pull Request" button that appears when you push the branch. Name the PR something descriptive like "User adds a Launcher".

  **Note:** It's a good idea to create the Pull Request early in the process (i.e. after writing your acceptance test in Step 2), before you're finished with the feature.  Just add "WIP" for "Work in Progress" to the name of your PR (e.g. "WIP - User adds a Launcher").  Change it to "RFR", or "Ready for Review", when the feature is complete.

11. **Merge the Pull Request.**  First make sure that the tests are passing and the app works in the browser.

Once a feature has been completed and merged in, update your local master branch, and then checkout a new branch off of master to get started on your next feature:

```no-highlight
git checkout master && git pull origin master
git checkout -b <my-next-feature>
