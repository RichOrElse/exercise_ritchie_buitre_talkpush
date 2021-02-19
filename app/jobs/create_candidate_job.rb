class CreateCandidateJob < ApplicationJob
  queue_as :new_candidates

  include HTTParty
  base_uri 'https://my.talkpush.com/api/talkpush_services'

  HEADERS = { accept: 'application/json', 'Content-Type' => 'application/json' }

  def perform(creation)
    id = creation.campaign_id
    body = {
      api_key: credentials.dig(:talkpush, :api_key),
      campaign_invitation: {
        first_name: creation.first_name,
        last_name: creation.last_name,
        email: creation.email,
        user_phone_number: creation.phone_number,
        source: ''
      }
    }

    response =  post("/campaigns/#{id}/campaign_invitations", body: body.to_json,
                                                              headers: HEADERS)
    creation.update response: response
  rescue HTTParty::ResponseError => error
    creation.update response: error.response
  end

  delegate :post, to: :class
end
