class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError

  delegate :credentials, to: :application
  delegate :application, :logger, to: Rails

  def self.to_proc
    method(:perform_later).to_proc
  end
end
