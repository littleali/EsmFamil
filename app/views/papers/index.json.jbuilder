json.array!(@papers) do |paper|
  json.extract! paper, :id
  json.url paper_url(paper, format: :json)
end
