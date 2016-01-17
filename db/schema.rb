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

ActiveRecord::Schema.define(version: 20160112205942) do

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
    t.integer  "durata"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "chiuso"
  end

  add_index "interventis", ["cliente_id"], name: "index_interventis_on_cliente_id"

end
