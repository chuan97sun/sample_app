class AddIntroToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :introduction, :string
  end
end
