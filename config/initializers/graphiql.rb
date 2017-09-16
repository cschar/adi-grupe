if Rails.env.development?

  puts "Initialized Graphiql w/ JWT_TOKEN: #{ENV['JWT_TOKEN']} \n\n\n\n\n\n ========="

  GraphiQL::Rails.config.headers['Authorization'] = -> (_ctx) {
    "bearer #{ENV['JWT_TOKEN']}"
  }
end