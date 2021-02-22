class Campaign < ApplicationRecord
  has_many :candidate_creations

  def import_candidates!(data)
    candidate_creations.create(data).tap do |results|
      import_candidates_failure! nil, count: results.size
    end
  end

  def import_candidates_failure!(failure, count: 0, at: DateTime.current)
    update import_candidates_failure: failure,
           import_candidates_count: count,
           import_candidates_at: at
  end

  delegate :count, to: :candidate_creations, prefix: true
end
