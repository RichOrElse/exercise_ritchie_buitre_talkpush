class CreateCampaigns < ActiveRecord::Migration[6.0]
  def change
    create_table :campaigns do |t|
      t.string :name
      t.string :spreadsheet_id, null: false

      t.json :import_candidates_failure
      t.timestamp :import_candidates_at

      t.timestamps
    end

    add_index :campaigns, :name
    add_index :campaigns, :spreadsheet_id, unique: true
  end
end
