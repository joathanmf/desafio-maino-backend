class CreateNotasFiscais < ActiveRecord::Migration[7.1]
  def change
    create_table :notas_fiscais do |t|
      t.string :num_serie
      t.string :num_nf
      t.datetime :dh_emi

      t.references :emitente, null: false, foreign_key: true
      t.references :destinatario, null: false, foreign_key: true

      t.decimal :v_icms, precision: 10, scale: 2
      t.decimal :v_ipi, precision: 10, scale: 2
      t.decimal :v_pis, precision: 10, scale: 2
      t.decimal :v_cofins, precision: 10, scale: 2

      t.timestamps
    end
  end
end
