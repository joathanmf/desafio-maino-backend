class CreateNfes < ActiveRecord::Migration[7.1]
  def change
    create_table :nfes do |t|
      t.string :num_serie
      t.string :num_nf
      t.datetime :dh_emi
      t.decimal :v_icms, precision: 10, scale: 2
      t.decimal :v_ipi, precision: 10, scale: 2
      t.decimal :v_pis, precision: 10, scale: 2
      t.decimal :v_cofins, precision: 10, scale: 2
      t.decimal :v_total, precision: 10, scale: 2
      t.decimal :v_trib, precision: 10, scale: 2
      t.references :issuer, null: false, foreign_key: true
      t.references :recipient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
