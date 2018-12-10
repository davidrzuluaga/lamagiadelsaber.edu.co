class CreatePadres < ActiveRecord::Migration[5.2]
  def change
    create_table :padres do |t|
      t.string :title
      t.text :body
      t.string :imgcover
      t.string :category
      t.string :pdflink

      t.timestamps
    end
  end
end
