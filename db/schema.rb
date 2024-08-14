# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_08_14_013819) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "destinatarios", force: :cascade do |t|
    t.string "cnpj", null: false
    t.string "x_nome", null: false
    t.string "x_lgr"
    t.string "nro"
    t.string "x_bairro"
    t.string "c_mun"
    t.string "x_mun"
    t.string "uf"
    t.string "cep"
    t.string "c_pais"
    t.string "x_pais"
    t.string "ind_ie"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emitentes", force: :cascade do |t|
    t.string "cnpj", null: false
    t.string "x_nome", null: false
    t.string "x_fant"
    t.string "x_lgr"
    t.string "nro"
    t.string "x_cpl"
    t.string "x_bairro"
    t.string "c_mun"
    t.string "x_mun"
    t.string "uf"
    t.string "cep"
    t.string "c_pais"
    t.string "x_pais"
    t.string "fone"
    t.string "ie"
    t.string "crt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notas_fiscais", force: :cascade do |t|
    t.string "num_serie"
    t.string "num_nf"
    t.datetime "dh_emi"
    t.bigint "emitente_id", null: false
    t.bigint "destinatario_id", null: false
    t.decimal "v_icms", precision: 10, scale: 2
    t.decimal "v_ipi", precision: 10, scale: 2
    t.decimal "v_pis", precision: 10, scale: 2
    t.decimal "v_cofins", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["destinatario_id"], name: "index_notas_fiscais_on_destinatario_id"
    t.index ["emitente_id"], name: "index_notas_fiscais_on_emitente_id"
  end

  create_table "produtos", force: :cascade do |t|
    t.string "x_prod"
    t.string "ncm"
    t.string "cfop"
    t.string "u_com"
    t.integer "q_com"
    t.decimal "v_un_com", precision: 10, scale: 2
    t.bigint "nota_fiscal_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nota_fiscal_id"], name: "index_produtos_on_nota_fiscal_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "notas_fiscais", "destinatarios"
  add_foreign_key "notas_fiscais", "emitentes"
  add_foreign_key "produtos", "notas_fiscais", column: "nota_fiscal_id"
end
