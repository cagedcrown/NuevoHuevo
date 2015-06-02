class CreateSchemes < ActiveRecord::Migration
  def change
    create_table :schemes do |t|
      t.string :font1
      t.string :font2
      t.string :color1
      t.string :color2
      t.string :color3
      t.string :color4
      t.string :color5

      t.timestamps
    end
  end
end
