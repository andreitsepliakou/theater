# frozen_string_literal: true

class CreateSpectacles < ActiveRecord::Migration[6.0]
  def change
    create_table :spectacles do |t|
      t.string :title, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.timestamps
    end
  end
end
