require 'rails_helper'

RSpec.describe CreateCandidateJob, type: :job do
  let!(:campaign) { Campaign.create(id: 4339, name: 'Default Campaign', spreadsheet_id: 'SPREADSHEET-ID') }
  let(:creation) { CandidateCreation.new(campaign: campaign) }
  let(:add_candidate) { change(campaign.candidate_creations, :count) }

  before do
    allow(subject).to receive(:credentials).and_return(talkpush: { api_key: '<API-KEY>' })
  end

  describe '#perform' do
    ['bad request', 'unauthorized'].each do |error|
      specify error do
        VCR.use_cassette("create candidate #{error}") do
          subject.perform(creation)
        end

        expect(creation).to_not be_ok
      end
    end

    context "with valid details" do
      let(:creation) do
        CandidateCreation.new(
          campaign: campaign,
          first_name: 'John',
          last_name: 'Doe',
          email: 'j.doe@example.com',
          phone_number: '5555555'
        )
      end

      ['success', 'duplicate'].each do |ok|
        specify ok do
          VCR.use_cassette("create candidate #{ok}") do
            subject.perform(creation)
          end

          expect(creation).to be_ok
        end
      end
    end
  end
end
