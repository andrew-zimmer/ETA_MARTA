require 'pry'
require 'open-uri'
require 'net/http'
require 'json'
require 'pry'
require 'addressable/uri'
class MartaAPIController
  
  def call 
    puts "Welcome to Marta Train Tracker!"
    puts "Enter your name:"
    get_name = gets.strip
    
    puts "Now enter your api_key:"
    get_key = gets.strip
    
    new_user = User.new(get_name, get_key)
    
    puts "lets track that train #{get_name}"
    
    train_id = MartaTrainScheduleImporter.train_api_call(get_key)[0]['TRAIN_ID']
    
    train = MartaTrainScheduleImporter.train_api_call(get_key).select{|hash| hash['TRAIN_ID'] == train_id}
    
   binding.pry
    
    
  end 
end 


class TrainSchedule

end


class MartaTrainScheduleImporter 
  
  def self.train_api_call(api_key)
    #the url to receive train schedule information from 
    url = "http://developer.itsmarta.com/RealtimeTrain/RestServiceNextTrain/GetRealtimeArrivals?apikey=#{api_key}"
  
    #store the url as a class object
    uri = URI.parse(URI.encode(url))
    
    # #sending a get request to return a value of Net::HTTPOK object 
    responsed = Net::HTTP.get_response(uri)
  
    # #parse using json
    train_array = JSON.parse(responsed.body)
  
  end 
end 

class User
  attr_accessor :name, :api_key, :all 
  @@all = []
  def initialize(user_name, api_key)
    @name = user_name
    @api_key = api_key
    @@all << self
  end 
  
  def self.all 
    @@all 
  end 
end 

MartaAPIController.new.call
