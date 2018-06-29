class CreateHelps < ActiveRecord::Migration[5.1]
  def change
    create_table :helps do |t|
      t.string :title
      t.string :mobile
      t.text :content

      t.timestamps
    end
  end
end
