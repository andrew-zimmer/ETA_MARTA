require 'open-uri'
require 'net/http'
require 'json'
require 'pry'
require 'addressable/uri'

class MartaTrainScheduleImporter 
  @@api_key = ''
  def self.train_api_call(api_key)
    #the url to receive train schedule information from 
    url = "http://developer.itsmarta.com/RealtimeTrain/RestServiceNextTrain/GetRealtimeArrivals?apikey=#{api_key}"
  
    #store the url as a class object
    uri = URI.parse(URI.encode(url))
    
    # #sending a get request to return a value of Net::HTTPOK object 
    responsed = Net::HTTP.get_response(uri)
  
    # #parse using json
    train_array = JSON.parse(responsed.body)
  
    binding.pry
  end 
end 

MartaTrainScheduleImporter.train_api_call('')