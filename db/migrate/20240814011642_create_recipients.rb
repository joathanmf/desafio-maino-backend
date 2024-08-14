class CreateRecipients < ActiveRecord::Migration[7.1]
  def change
    create_table :recipients do |t|
      t.string :cnpj, null: false
      t.string :x_nome, null: false
      t.string :x_lgr
      t.string :nro
      t.string :x_bairro
      t.string :c_mun
      t.string :x_mun
      t.string :uf
      t.string :cep
      t.string :c_pais
      t.string :x_pais
      t.string :ind_ie

      t.timestamps
    end
  end
end
