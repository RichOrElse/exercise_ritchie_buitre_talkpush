class CandidatesController < ApplicationController
  before_action -> { @campaign = Campaign.last }

  def index
    @campaign = CampaignPresenter.new(@campaign, view_context)
    @candidates = @campaign.candidate_creations.map(&CandidatePresenter)

    if @campaign.import_candidates_failure?
      flash.alert = "Import Failed: #{@campaign.import_candidates_failure_message}"
    end
  end

  def import
    ImportNewCandidatesJob.perform_later @campaign

    redirect_to root_path, notice: 'Importing Candidates. Reload this page to see changes.'
  end
end
