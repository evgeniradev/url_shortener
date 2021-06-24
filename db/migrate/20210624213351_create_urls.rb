# frozen_string_literal: true

class CreateUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :urls do |t|
      t.belongs_to :user
      t.text :url, null: false
      t.string :slug, null: false
      t.integer :visits, default: 0, null: false
      t.timestamps
    end

    add_index :urls, %i[url user_id], unique: true
    add_index :urls, :slug, unique: true
  end
end
