
class MartaAPIController
  attr_writer :key

  def initialize(key)
    @key = key
    marta_import(key)
  end

  def call
    puts "Welcome to ETA MARTA!"


    #binding.pry

  end

  def marta_import(key)
    MartaTrainScheduleImporter.new(key).import
  end

end
