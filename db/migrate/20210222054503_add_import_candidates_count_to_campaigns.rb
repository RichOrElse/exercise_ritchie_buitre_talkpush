class AddImportCandidatesCountToCampaigns < ActiveRecord::Migration[6.0]
  def change
    add_column :campaigns, :import_candidates_count, :integer, default: 0
  end
end
