# Erweiterung von Devise
class AddPersonalDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birthday, :date # zu Users wird das Geburtsdatum hinzugefügt
    add_column :users, :place_of_residence, :string # zu Users wird der Wohnort hinzugefügt
  end
end
