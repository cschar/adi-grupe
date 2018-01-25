desc "gen treesssssss for the app"
task gen_trees: :environment do
  tree_type = [
      'birch',
      'maple',
      'evergreen',
      'ash',
      'ironwood'
  ]

  temp = [
      'Hot',
      'lukewarm',
      'tepid',
      'cold'
  ]

  15.times do
    Firetree.create(name: FFaker::Food.ingredient,
                    body: tree_type.sample + temp.sample,
                    user_id:1)
  end

end