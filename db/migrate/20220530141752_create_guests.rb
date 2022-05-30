class CreateGuests < ActiveRecord::Migration[6.1]
  def change
    create_table :guests do |t|

      t.timestamps
    end
  end
end
