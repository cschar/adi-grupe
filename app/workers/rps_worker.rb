class RpsWorker
  include Sidekiq::Worker

  def wins_rps(first, second)
    if first.ltype == 'rock' && second.ltype == 'scissors'
        return true
    end
    if first.ltype == 'paper' && second.ltype == 'rock'
      return true
    end
    if first.ltype == 'scissors' && second.ltype == 'paper'
      return true
    end
  end

  def wins_rps2(first, second)
    if first.ltype == 'rock' && second.ltype == 'scissors'
      return 2
    end
    if first.ltype == 'rock' && second.ltype == 'rock'
      return 1
    end
    if first.ltype == 'rock' && second.ltype == 'paper'
      return 0
    end

    if first.ltype == 'paper' && second.ltype == 'rock'
      return 2
    end
    if first.ltype == 'paper' && second.ltype == 'paper'
      return 1
    end
    if first.ltype == 'paper' && second.ltype == 'scissors'
      return 0
    end

    if first.ltype == 'scissors' && second.ltype == 'rock'
      return 0
    end
    if first.ltype == 'scissors' && second.ltype == 'paper'
      return 2
    end
    if first.ltype == 'scissors' && second.ltype == 'scissors'
      return 1
    end
  end

  def perform(*args)
    # Do something
    #TODO figure out if POSTGIS can be leveraged here

    unprocessed_lmarkers = Lmarker.where(is_new: true)

    # habitable canada roughly
    # ~ lng -138 --> -54
    # lat 44 -> 56
    #1 degree of Longitude =
    # cosine (latitude in decimal degrees) *
    # length of degree (miles) at equator.

    # for now...
    d = 0.0027  # lng/lat distance...
    fn = '/var/tmp/foop'
    open(fn, 'a') { |f|
      f.puts Time.now.strftime("%d/%m/%Y %H:%M")
      f.puts("total unproccessed " + String(unprocessed_lmarkers.size))

      unprocessed_lmarkers.each do |lm|

      # simple box region
      #TODO: acutal circle
      nearby_lmarkers = Lmarker.where(
          "lat <= :north AND lat >= :south
       AND lng >= :west AND lng <= :east",
          {north: lm.lat + d, south:lm.lat - d,
           west:lm.lng - d, east:lm.lng + d} )

      f.puts("Nearby markers for #{lm.id} #{lm.ltype}")
      nearby_lmarkers.each do |nearby_lm|


        if wins_rps(lm, nearby_lm)
          f.puts "id: #{nearby_lm.id} -- Delete -- #{nearby_lm.ltype}"
          nearby_lm.delete
        else
          f.puts "id: #{nearby_lm.id} -- Tie -- #{nearby_lm.ltype}"
        end
      end

      lm.is_new = false
      lm.save
    end
    }
  end
end
