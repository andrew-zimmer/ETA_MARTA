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
    
    puts "Lets find out where you want to go."
    puts "Select which available rail line you want to use to select your destination:"
    
    #gives a list of rail lines that are listed in the api 
    TrainSchedule.train_railline(new_user.api_key).each.with_index(1){|index, element| puts "#{element}: #{index}"}
    
    #receives the user's answer for which rail line 
    get_rail  = gets.strip.to_i
    rail_input = TrainSchedule.train_railline(new_user.api_key)[get_rail -1]
    
    TrainSchedule.train_from_rail_line(get_key, rail_input).each.with_index(1){|index, element| puts "#{element}: #{index}"}
    
    
    
    
    # puts "Select from the provide options using the corresponding number."
    # #list of train stations 
    # TrainSchedule.train_stations(new_user.api_key).each.with_index(1){|index, element| puts "#{element}: #{index}"}
    
  end 
end 


class TrainSchedule
  def self.train_stations(api_key) 
    MartaTrainScheduleImporter.train_api_call(api_key).collect {|hash| hash['STATION']}.uniq
  end 
  
  def self.train_railline(api_key)
    array = MartaTrainScheduleImporter.train_api_call(api_key).collect {|hash| hash['LINE']}.uniq.sort
    #binding.pry
    array
  end 
  
  def self.train_from_rail_line(api_key, user_line_input)
    MartaTrainScheduleImporter.train_api_call(api_key).select {|hash| hash['LINE'] == user_line_input}
  end 
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
