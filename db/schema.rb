# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160209103056) do

  create_table "clientis", force: true do |t|
    t.string   "nome"
    t.string   "piva"
    t.string   "codfisc"
    t.text     "email"
    t.string   "telefono"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comunicazionis", force: true do |t|
    t.text     "tipo"
    t.datetime "data"
    t.text     "destinatario"
    t.text     "testo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "interventi_id"
  end

  create_table "contrattis", force: true do |t|
    t.integer  "clienti_id"
    t.date     "acquisto"
    t.integer  "ore"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interventis", force: true do |t|
    t.integer  "cliente_id"
    t.date     "data"
    t.string   "apparecchiatura"
    t.text     "intervento"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "chiuso"
    t.string   "codice"
    t.integer  "operator_id"
  end

  add_index "interventis", ["cliente_id"], name: "index_interventis_on_cliente_id", using: :btree

  create_table "utentis", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.string   "nome"
    t.integer  "clienti_id"
    t.boolean  "operatore",              default: false
  end

  add_index "utentis", ["email"], name: "index_utentis_on_email", unique: true, using: :btree
  add_index "utentis", ["reset_password_token"], name: "index_utentis_on_reset_password_token", unique: true, using: :btree

  create_table "works", force: true do |t|
    t.integer  "interventi_id"
    t.integer  "operator_id"
    t.date     "data"
    t.integer  "durata"
    t.text     "descrizione"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
