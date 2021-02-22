class CampaignPresenter < ApplicationPresenter
  def import_candidates_failure_message
    JSON(import_candidates_failure).dig('error', 'message')
  rescue
    import_candidates_failure
  end

  def last_import_in_words
    return 'never' unless import_candidates_at?

    "#{h.time_ago_in_words(import_candidates_at)} ago"
  end
end
