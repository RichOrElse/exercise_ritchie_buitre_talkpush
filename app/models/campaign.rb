class Campaign < ApplicationRecord
  has_many :candidate_creations

  def import_candidates!(data)
    import_candidates_failure! nil

    candidate_creations.create(data)
  end

  def import_candidates_failure!(failure)
    update import_candidates_failure: failure, import_candidates_at: DateTime.current
  end

  delegate :count, to: :candidate_creations, prefix: true
end
