class CandidateCreation < ApplicationRecord
  belongs_to :campaign

  def response=(response)
    self.response_code = response.code
    self.response_body = response.body
  end

  def ok?
    response_code == 200
  end
end
