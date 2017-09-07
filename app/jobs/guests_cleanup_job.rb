class GuestsCleanupJob < ApplicationJob
  queue_as :default

  def perform(*args)
    unprocessed_lmarkers = Lmarker.where(is_new: true)
    File.write('/var/tmp/foop', unprocessed_lmarkers.length)
  end
end
