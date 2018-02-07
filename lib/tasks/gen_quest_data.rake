
task gen_quest_data: :environment do



  grupe1 = Grupe.first
  10.times do |x|
      q = Quest.create! name: FFaker::Color.name, body: FFaker::Book.description(2)
      Qglink.create quest: q, grupe: grupe1, subject: FFaker::Name.first_name + "'s Link"
  end



  q1 = Quest.create! name: "quest1 - talker", body: "Talk about XYZ"
  q2 = Quest.create! name: "quest2 - walker", body: "Walk to nearby location < some location of interest OR other tavern>"
  q3 = Quest.create! name: "quest - some type3",  body: "(user 1 - profession {song collector}): Sing a song / learn a verse / write a verse"
  q4 = Quest.create! name: "quest4",
                body: "Share a song. What do you think about it and how does it make you feel.
                       Tooltip Here exploding feelings into choice box archetypes (glad/sad/mad/tired/confused/lonely/excited/friendly/calm)"

  grupe2 = Grupe.first(2)[1]

  u = User.first
  Qglink.create quest: q1, grupe: grupe2, subject: u.id.to_s

  ### some cool querying the a 'transitive' association (extra model)
  Quest.find_by(name: 'talker').grupes  # all of q1s grupes


  Quest.joins(:qglinks).where(qglinks: {subject: u.id.to_s}).distinct.pluck(:name)

  # get all Quest name attributes who belong to the user id who are linked to the
  # grupe with the name 'bluegrupe'
    Quest.joins(:grupes).joins(:qglinks).where(qglinks: {subject: u.id.to_s},
               grupes: {name: 'bluegrupe'}).distinct.map {|x| puts x.name}


end



