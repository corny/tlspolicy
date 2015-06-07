class CreateMxRecords < ActiveRecord::Migration
  def change
    create_table :mx_records, id: false do |t|
      t.string  :hostname, null: false
      t.inet    :addresses, null: false, array: true, index: true

      t.boolean :dns_secure, index: true
      t.string  :dns_error, index: true
      t.string  :dns_bogus

      t.string :txt
      t.boolean :starttls, index: true
      t.string :cert_problems, array: true, index: true
      t.datetime :updated_at, index: true
    end
    execute "ALTER TABLE mx_records ADD PRIMARY KEY (hostname)"
  end
end