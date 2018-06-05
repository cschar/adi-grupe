Split.configure do |config|
  config.allow_multiple_experiments = true
  config.enabled = true
  
  # https://github.com/splitrb/split
  # config.persistence = :cookie
  # config.persistence_cookie_length = 2592000 # 30 days

end