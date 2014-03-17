json.array!(@governance_score_yahoos) do |governance_score_yahoo|
  json.extract! governance_score_yahoo, :id
  json.url governance_score_yahoo_url(governance_score_yahoo, format: :json)
end
