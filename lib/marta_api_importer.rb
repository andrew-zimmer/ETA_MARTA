class MartaTrainScheduleImporter
  attr_accessor :key

  def initialize(key)
    @key = key
  end

  def train_api_call
    #the url to receive train schedule information from
    url = "http://developer.itsmarta.com/RealtimeTrain/RestServiceNextTrain/GetRealtimeArrivals?apikey=#{key}"

    #store the url as a class object
    uri = URI.parse(URI.encode(url))

    # #sending a get request
    responsed = Net::HTTP.get_response(uri)

    # #parse using json into an array
    train_array = JSON.parse(responsed.body)
  end

  def import
    self.train_api_call.each do |hash|
      Train.create(hash)
    end
  end

end
