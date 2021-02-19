class CreateCandidateCreations < ActiveRecord::Migration[6.0]
  def change
    create_table :candidate_creations do |t|
      t.belongs_to :campaign, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number

      t.json :response_body
      t.integer :response_code

      t.timestamp :timestamp
      t.timestamps
    end

    add_index :candidate_creations, :response_code
  end
end
