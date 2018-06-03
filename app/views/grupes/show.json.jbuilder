json.partial! "grupes/grupe_blob", grupe: @grupe, quests: @quests

#json.users @grupe.users, :id, :display_name

json.users do
  json.array! @grupe.users do |user|
    
    json.display_name user.display_name
    json.id user.id
    json.confirmed user.confirmed_for(@grupe)
  
  end
end