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

ActiveRecord::Schema.define(version: 20150312211751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "certificates", force: :cascade do |t|
    t.binary   "subject_id",          null: false
    t.binary   "issuer_id",           null: false
    t.binary   "key_id",              null: false
    t.integer  "key_size"
    t.string   "key_algorithm",       null: false
    t.string   "signature_algorithm", null: false
    t.boolean  "is_ca"
    t.boolean  "is_self_signed"
    t.integer  "days_valid"
    t.datetime "first_seen_at",       null: false
  end

  add_index "certificates", ["days_valid"], name: "index_certificates_on_days_valid", using: :btree
  add_index "certificates", ["is_ca"], name: "index_certificates_on_is_ca", using: :btree
  add_index "certificates", ["is_self_signed"], name: "index_certificates_on_is_self_signed", using: :btree
  add_index "certificates", ["issuer_id"], name: "index_certificates_on_issuer_id", using: :btree
  add_index "certificates", ["key_algorithm"], name: "index_certificates_on_key_algorithm", using: :btree
  add_index "certificates", ["key_id"], name: "index_certificates_on_key_id", using: :btree
  add_index "certificates", ["key_size"], name: "index_certificates_on_key_size", using: :btree
  add_index "certificates", ["signature_algorithm"], name: "index_certificates_on_signature_algorithm", using: :btree
  add_index "certificates", ["subject_id"], name: "index_certificates_on_subject_id", using: :btree

  create_table "domains", force: :cascade do |t|
    t.string   "name",                    null: false
    t.text     "mx_hosts",   default: [],              array: true
    t.boolean  "dns_secure"
    t.string   "dns_error"
    t.string   "dns_bogus"
    t.datetime "updated_at"
  end

  add_index "domains", ["dns_secure"], name: "index_domains_on_dns_secure", using: :btree
  add_index "domains", ["mx_hosts"], name: "index_domains_on_mx_hosts", using: :btree
  add_index "domains", ["name"], name: "index_domains_on_name", unique: true, using: :btree
  add_index "domains", ["updated_at"], name: "index_domains_on_updated_at", using: :btree

  create_table "mx_hosts", force: :cascade do |t|
    t.inet     "address",                null: false
    t.string   "error"
    t.boolean  "starttls"
    t.binary   "tls_versions",                        array: true
    t.binary   "tls_cipher_suites",                   array: true
    t.boolean  "cert_trusted"
    t.boolean  "cert_expired"
    t.string   "cert_error"
    t.binary   "certificate_id"
    t.binary   "ca_certificate_ids",                  array: true
    t.binary   "chain_root_id"
    t.binary   "chain_intermediate_ids",              array: true
    t.integer  "ecdhe_curve_type"
    t.integer  "ecdhe_curve_id"
    t.datetime "updated_at",             null: false
  end

  add_index "mx_hosts", ["address"], name: "index_mx_hosts_on_address", unique: true, using: :btree
  add_index "mx_hosts", ["ca_certificate_ids"], name: "index_mx_hosts_on_ca_certificate_ids", using: :btree
  add_index "mx_hosts", ["cert_error"], name: "index_mx_hosts_on_cert_error", using: :btree
  add_index "mx_hosts", ["cert_expired"], name: "index_mx_hosts_on_cert_expired", using: :btree
  add_index "mx_hosts", ["cert_trusted"], name: "index_mx_hosts_on_cert_trusted", using: :btree
  add_index "mx_hosts", ["certificate_id"], name: "index_mx_hosts_on_certificate_id", using: :btree
  add_index "mx_hosts", ["chain_intermediate_ids"], name: "index_mx_hosts_on_chain_intermediate_ids", using: :btree
  add_index "mx_hosts", ["chain_root_id"], name: "index_mx_hosts_on_chain_root_id", using: :btree
  add_index "mx_hosts", ["ecdhe_curve_id"], name: "index_mx_hosts_on_ecdhe_curve_id", using: :btree
  add_index "mx_hosts", ["ecdhe_curve_type"], name: "index_mx_hosts_on_ecdhe_curve_type", using: :btree
  add_index "mx_hosts", ["error"], name: "index_mx_hosts_on_error", using: :btree
  add_index "mx_hosts", ["starttls"], name: "index_mx_hosts_on_starttls", using: :btree
  add_index "mx_hosts", ["tls_cipher_suites"], name: "index_mx_hosts_on_tls_cipher_suites", using: :btree
  add_index "mx_hosts", ["tls_versions"], name: "index_mx_hosts_on_tls_versions", using: :btree

  create_table "mx_records", primary_key: "hostname", force: :cascade do |t|
    t.inet     "addresses",                  array: true
    t.boolean  "dns_secure",    null: false
    t.string   "dns_error"
    t.string   "dns_bogus"
    t.string   "txt"
    t.boolean  "starttls",      null: false
    t.string   "cert_problems",              array: true
    t.datetime "updated_at",    null: false
  end

  add_index "mx_records", ["addresses"], name: "index_mx_records_on_addresses", using: :btree
  add_index "mx_records", ["cert_problems"], name: "index_mx_records_on_cert_problems", using: :btree
  add_index "mx_records", ["dns_error"], name: "index_mx_records_on_dns_error", using: :btree
  add_index "mx_records", ["dns_secure"], name: "index_mx_records_on_dns_secure", using: :btree
  add_index "mx_records", ["starttls"], name: "index_mx_records_on_starttls", using: :btree
  add_index "mx_records", ["updated_at"], name: "index_mx_records_on_updated_at", using: :btree

  create_table "raw_certificates", force: :cascade do |t|
    t.binary "raw", null: false
  end

  add_foreign_key "certificates", "raw_certificates", column: "id"
end
