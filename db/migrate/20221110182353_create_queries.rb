class CreateQueries < ActiveRecord::Migration[5.2]
  def change
    create_table :queries do |t|
      t.string :name

      t.timestamps
    end
  end
end
