json.array!(@works) do |work|
  json.extract! work, :id, :data, :durata, :descrizione
  json.url work_url(work, format: :json)
end
