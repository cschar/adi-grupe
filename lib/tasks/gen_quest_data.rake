
task gen_quest_data: :environment do


  #these could be individual frontend vue/react components based on 
  # some styling "type"
  q01 = Quest.create! name: "talkbookr", body: "<div class=\"color3\">\n      <h2> Talk Boo-ker - Fiction style</h2>\n      <i class=\"fa fa-microphone fa-2x\"></i>\n\n      <pre>\n        User1 is interested in a Talk BOOKER.\n        Discuss the plot, the characters, the emotions and feelings the text created.\n        The thoughts and questions it created after reading it...\n      book is left in the comments. (or add an API call to goodreads to load it up? lol)\n      </pre>\n    </div>\n"
  q02 = Quest.create! name: "Language learner",
      body: <<-EOD 
      <div>
      <h2> Language Learner - (French/Mandarin)|| <span class="color2">[[ knowledger + 1]]</span></h2>
      <i class="fa fa-language fa-4x"></i>
      <span class="color4"> practice or explore a new language </span>
      
      <pre>
        Conversation focused language learning.
        Talk 1,2,5 minutes without speaking english
        vocal cords



      </pre>
    </div>
    
    EOD
  
  q03 = Quest.create! name: "Walk window gazer",
    body: <<-EOD
    <div class="color3">
      <h2> Walk window gazer </h2>
      <i class="fa fa-fire fa-4x"></i>

      <pre>
        Check the downtown shop windows.
        Zoom in for a look then zoom out.

      </pre>


    </div>
    EOD

    q04 = Quest.create! name: "Beer Brewer",
    body: <<-EOD
    <div>
      <h2> Beer brewer </h2>
      <i class="fa fa-beer fa-2x"></i>
      <div class="color2"> User <%= @grupe.users.first ? @grupe.users.first.display_name : ""%> : </div>
      <pre>
        Beer connaisseurs.
        Brewing tips.
        Beer trivia.

      </pre>


    </div>
    EOD

    q05 = Quest.create! name: "History Buffalos",
    body: <<-EOD
    <div>
      <h2> History Buff(alo)s </h2>
      <i class="fa fa-hourglass-o fa-2x"></i>

      <pre>
        Gather at the watering hole to discuss history.
        rant about extraordinary events.
        Geek out about how civilizations survived through the ages.

      </pre>


    </div>
    EOD


  q1 = Quest.create! name: "talker1", body: "Talk about XYZ"
  q2 = Quest.create! name: "quest2 - walker", body: "Walk to nearby location < some location of interest OR other tavern>"
  q3 = Quest.create! name: "quest - some type3",  body: "(user 1 - profession {song collector}): Sing a song / learn a verse / write a verse"
  q4 = Quest.create! name: "quest4",
                body: "Share a song. What do you think about it and how does it make you feel.
                       Tooltip Here exploding feelings into choice box archetypes (glad/sad/mad/tired/confused/lonely/excited/friendly/calm)"



  # grupe1 = Grupe.first
  # 10.times do |x|
  #     q = Quest.create! name: FFaker::Color.name, body: FFaker::Book.description(2)
  #     Qglink.create quest: q, grupe: grupe1, subject: FFaker::Name.first_name + "'s Link"
  # end
                     
  # grupe2 = Grupe.first(2)[1]
 
  # u = User.first
  # Qglink.create quest: q1, grupe: grupe2, subject: u.id.to_s

  # ### some cool querying the a 'transitive' association (extra model)
  # Quest.find_by(name: 'talker1').grupes  # all of q1s grupes


  # Quest.joins(:qglinks).where(qglinks: {subject: u.id.to_s}).distinct.pluck(:name)

  # # get all Quest name attributes who belong to the user id who are linked to the
  # # grupe with the name 'bluegrupe'
  #   Quest.joins(:grupes).joins(:qglinks).where(qglinks: {subject: u.id.to_s},
  #              grupes: {name: 'bluegrupe'}).distinct.map {|x| puts x.name}


end



