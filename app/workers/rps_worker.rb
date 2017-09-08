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
      f.puts "#{Time.now.strftime("%d/%m/%Y %H:%M")} [unprocessed: #{unprocessed_lmarkers.size}"

      unprocessed_lmarkers.each do |lm|

      # simple box region
      #TODO: acutal circle
      nearby_lmarkers = Lmarker.where("
       id != :current_lmarker AND user_id != :current_lmarker_user_id
       AND lat <= :north AND lat >= :south
       AND lng >= :west AND lng <= :east",
          {current_lmarker: lm.id, current_lmarker_user_id: lm.user_id,
           north: lm.lat + d, south:lm.lat - d,
           west:lm.lng - d, east:lm.lng + d} )

      f.puts("Nearby markers for #{lm.id}[user #{lm.user_id}] #{lm.ltype}")
      lm_deleted = false
      nearby_lmarkers.each do |nearby_lm|

        rps_result = wins_rps2(lm, nearby_lm)

        if rps_result == 2
          #TODO add index user to lmarker
          user = User.find(lm.user_id)
          user.points = user.points + 1
          user.save

          f.puts "#{nearby_lm.id} [user #{nearby_lm.user_id}] -- #{nearby_lm.ltype} -- Loses "

          #BUG ,
          #if nearby_lm, later iterated over in unprocessed_lmarkers?
          nearby_lm.delete
        elsif rps_result == 1
          f.puts "#{nearby_lm.id} [user #{nearby_lm.user_id}] -- #{nearby_lm.ltype} -- Tie "
        else
          user = User.find(nearby_lm.user_id)
          user.points = user.points + 1
          user.save

          f.puts "#{nearby_lm.id} [user #{nearby_lm.user_id}] -- #{nearby_lm.ltype} -- Wins "
          lm_deleted = true
        end
      end

      if lm_deleted
        lm.delete
      else
        lm.is_new = false
        lm.save
      end

    end
    }
  end
end
