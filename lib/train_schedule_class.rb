require 'pry'


class TrainSchedule
  def self.train_stations(api_key) 
    MartaTrainScheduleImporter.train_api_call(api_key).collect {|hash| hash['STATION']}.uniq
  end 
end

TrainSchedule.train_stations('233df857-73b8-4ecf-812b-e0bd443c9a86')