require 'rails_helper'

RSpec.describe ImportNewCandidatesJob, type: :job do
  let!(:campaign) { Campaign.create(id: 4339, name: 'Default Campaign', spreadsheet_id: 'SPREADSHEET-ID') }

  before do
    allow(subject).to receive(:credentials).and_return(google: { api_key: 'GOOGLE-API-KEY' })
  end

  describe '#perform' do
    let(:perform) { receive(:perform_later).with(CandidateCreation) }

    ['bad request', 'not found'].each do |error|
      specify error do
        expect(CreateCandidateJob).to_not perform

        VCR.use_cassette("import new candidates #{error}") do
          subject.perform(campaign)
        end

        expect(campaign.candidate_creations).to be_blank
        expect(campaign).to be_import_candidates_failure
      end
    end

    it "imports no new candidates" do
      expect(CreateCandidateJob).to_not perform

      VCR.use_cassette("import_new_candidates_none") do
        expect { subject.perform(campaign) }.to_not change(campaign.candidate_creations, :count)
      end

      expect(campaign).to_not be_import_candidates_failure
    end

    it "imports all new candidates" do
      expect(CreateCandidateJob).to perform.at_least(:once)

      VCR.use_cassette("import_new_candidates_all") do
        subject.perform(campaign)
      end

      expect(campaign.candidate_creations).to be_many
      expect(campaign).to_not be_import_candidates_failure
    end

    it "imports last new candidates" do
      expect(CreateCandidateJob).to perform.twice

      2.times { campaign.candidate_creations << CandidateCreation.new }

      VCR.use_cassette("import_new_candidates_last") do
        expect { subject.perform(campaign) }.to change(campaign.candidate_creations, :count).from(2).to(4)
      end

      expect(campaign).to_not be_import_candidates_failure
    end
  end
end
