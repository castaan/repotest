# Homepage (Root path)
require 'net/https'
require 'json'

forecast_api_key = "a158822742ac6f8b7a4aa370d23b456f"

#proxy_addr = 'proxy.prod.oami.eu'
#proxy_port = 3128

#########  PROPOSAL SOLUTION FOR PROXY  ############
#env_proxy = ENV['https_proxy'] || ENV['HTTPS_PROXY']
#proxy_addr = uri.split(':')[0].strip
#proxy_port = uri.split(':')[1].strip

# Latitude, Longitude for location For Valencia City SPAIN
forecast_location_lat = "39.4813878"
forecast_location_long = "-0.3454663"

# Unit Format
# "us" - U.S. Imperial
# "si" - International System of Units
# "uk" - SI w. windSpeed in mph
forecast_units = "si"
  
http = Net::HTTP.new("api.forecast.io") # With Proxy use ("api.forecast.io", 443, proxy_addr, proxy_port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER
response = http.request(Net::HTTP::Get.new("/forecast/#{forecast_api_key}/#{forecast_location_lat},#{forecast_location_long}?units=#{forecast_units}"))
forecast = JSON.parse(response.body)  
forecast_current_temp = forecast["currently"]["temperature"].round


##### Sinatra Methods ######
get '/' do
  @variable = forecast_current_temp
  erb :index
end

get '/Valencia' do
  @variable = forecast_current_temp
  erb :valencia
end
