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