class RenewWorker
  include Sidekiq::Worker

  def perform(*args)
      Lmarker.all.each do |lm|
          lm.is_new = true
          lm.save
      end
  end
end
