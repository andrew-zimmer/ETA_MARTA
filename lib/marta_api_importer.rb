require 'open-uri'
require 'net/http'
require 'json'
require 'pry'

class MartaTrainScheduleImporter 
  #the url to receive train schedule information from 
  url = 'http://developer.itsmarta.com/RealtimeTrain/
RestServiceNextTrain/GetRealtimeArrivals?apikey=233df857-73b8-4ecf-812b-e0bd443c9a86'

  #store the url as a class object
  uri = URI.parse(url)
  
  #sending a get request to return a value of Net::HTTPOK object 
  responsed = Net::HTTP.get_response(uri)
  
  #parse using json
  hash = JSON.parse(responsed.body)
  
  binding.pry
end 