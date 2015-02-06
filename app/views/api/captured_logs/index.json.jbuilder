json.array!(@api_captured_logs) do |api_captured_log|
  json.extract! api_captured_log, :id, :captured_at, :player, :team
  json.portal do
    json.extract! api_captured_log.portal, :id, :lat, :lng, :name, :address
  end
end
