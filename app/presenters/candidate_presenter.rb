class CandidatePresenter < ApplicationPresenter
  def response_message
    message, error  = response.values_at(:message, :error)
    message || error
  end

  def response
    JSON.parse(response_body, symbolize_names: true)
  rescue
    {}
  end

  def status
    return 'Not Created' unless response_code?
    return 'OK' if ok?

    'Error'
  end
end
