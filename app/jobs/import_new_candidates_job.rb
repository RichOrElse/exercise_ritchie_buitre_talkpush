class ImportNewCandidatesJob < ApplicationJob
  queue_as :new_candidates

  include HTTParty
  base_uri 'https://sheets.googleapis.com/v4'

  def perform(campaign)
    id = campaign.spreadsheet_id
    top = 2 + campaign.candidate_creations_count
    api_key = credentials.dig(:google, :api_key)

    response = get("/spreadsheets/#{id}/values/A#{top}:E#{top + 99}?key=#{api_key}")

    if response.ok?
      details = response.fetch('values', []).map(&CandidateDetails).map(&:to_h)
      campaign.import_candidates!(details).each(&CreateCandidateJob)
    else
      campaign.import_candidates_failure! response.body
    end

  rescue HTTParty::ResponseError => error
    campaign.import_candidates_failure! error.response.body
  end

  delegate :get, to: :class
end
