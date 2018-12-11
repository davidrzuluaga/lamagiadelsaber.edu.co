class CreateConfiguras < ActiveRecord::Migration[5.2]
  def change
    create_table :configuras do |t|
      t.string :name
      t.string :config

      t.timestamps
    end
  end
end
