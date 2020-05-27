
class MartaAPIController
  attr_writer :key

  def initialize(key)
    @key = key
    marta_import(key)
  end
  @@rail = ''
  @@station = ''
  @@trains = []
  def call
    puts "Welcome to ETA MARTA!"
    puts "Pick a rail-line, choose one with the corresponding number.\nHere is a list of avialable lines:"
    binding.pry

    #gives a list of rail lines to choose from by user
    list_lines_with_index

    #receives the input from user to select from an available list of rail lines
    get_line = gets.strip.to_i

    if get_line.between?(1,RailLine.list_lines.length)
      #put puts a list of train stations based on the rail line chosen
      list_stations_from_line(get_line)

      #receives the input from user to select from an available list of stations based on a rail line
      get_station = gets.strip.to_i

      if get_station == 0

      elsif get_station == 00
        refresh
      else
        while !get_station.between?(0, @@station.length)
          puts "Lets try this again:"
          list_stations_from_line(get_line)
          get_station = gets.strip.to_i

        end

        list_trains_from_station(get_station)
        puts "\nEnter 0 to restart:\nEnter 00 to refresh\n"
        get_input = gets.strip
      end

    else
      call
    end



  end

  def marta_import(key)
    MartaTrainScheduleImporter.new(key).import
  end

  def list_lines_with_index
    RailLine.list_lines.each.with_index(1){|element, index| puts "#{index}: #{element} Line \n--------------"}
  end

  def list_stations_from_line(input)
    # if input.between?(1,RailLine.list_lines.length)
      puts "\nHere is the available list of stations on the line you chose\n."
      puts "Choose the station by typing the corresponding number:"
      puts "Or enter 0 to start over"
      @@rail = RailLine.list_lines[input-1]
      @@station = RailLine.find_station_from_line(@@rail)
      RailLine.find_station_from_line(@@rail).each.with_index(1){|element, index| puts "\n#{index}: #{element}\n-----------------------"}
    # end
  end

  def list_trains_from_station(input)
    # if input.between?(1, @station.length)
      @@station = @@station[input-1]
      puts "\nHere are a list of incoming trains for #{@@station} on the #{@@rail} line:\n"
      puts ""

      Station.find_self_and_trains(@@station).select{|hash| hash['line'] == @@rail}.each.with_index(1) do |element, index|
        puts "#{index}: Destination: #{element['destination']}\n"
        puts "   Direction: #{element['dir']}\n"
        puts "   Base Time: #{element['event_time']}\n"
        puts "   Waiting Time: #{element['waiting_time']}\n"
        puts "   Line: #{element['line']}\n"
        puts "----------------------------"
      end

    #end
  end

  def refresh
    if @@rail != "" && @@station != "" && @@trains != []

    end
  end

end
