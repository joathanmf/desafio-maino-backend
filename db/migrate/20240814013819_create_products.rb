class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :x_prod
      t.string :ncm
      t.string :cfop
      t.string :u_com
      t.integer :q_com
      t.decimal :v_un_com, precision: 10, scale: 2

      t.references :nfe, null: false, foreign_key: { to_table: :nfes }

      t.timestamps
    end
  end
end
