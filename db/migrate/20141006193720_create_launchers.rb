class CreateLaunchers < ActiveRecord::Migration
  def change
    create_table :launchers do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.text :bio

      t.timestamps
    end

    add_index :launchers, :email, unique: true
  end
end
