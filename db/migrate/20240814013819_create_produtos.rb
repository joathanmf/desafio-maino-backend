class CreateProdutos < ActiveRecord::Migration[7.1]
  def change
    create_table :produtos do |t|
      t.string :x_prod
      t.string :ncm
      t.string :cfop
      t.string :u_com
      t.integer :q_com
      t.decimal :v_un_com, precision: 10, scale: 2

      t.references :nota_fiscal, null: false, foreign_key: { to_table: :notas_fiscais }

      t.timestamps
    end
  end
end
