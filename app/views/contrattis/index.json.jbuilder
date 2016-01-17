json.array!(@contrattis) do |contratti|
  json.extract! contratti, :id, :clienti_id, :acquisto, :ore, :note
  json.url contratti_url(contratti, format: :json)
end
