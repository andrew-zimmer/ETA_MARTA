
class MartaAPIController
  attr_writer :key

  def initialize(key)
    @key = key
    marta_import(key)
  end
  @@rail = ''
  @@direction = ''
  @@station = ''
  @@trains = []
  @@initial_options = ["Rail-Line and Direction", "Station", "Trains"]
  def call
    puts "Welcome to ETA MARTA!"

    puts "Select a search option by entering the corresponding number:"
    puts "1: Search by Rail-Line or Direction of travel"
    puts "2: Choose from a list of stations to see all incoming trains"
    puts "3: See all trains currently operating"
    get_start = gets.strip.to_i

    if !get_start.between?(1,3)
      puts "Lets start over and try again"
      call
#---------------------choose from rail line or direction-------------------
    elsif get_start == 1
      #Choosing from an availible rail-line and/or direction
      puts "Choose one with the corresponding number.\nHere is a list of avialable lines and directions:"
      puts "\nEnter 0 to restart.\n"


      #gives a list of rail lines and direction to choose from by user
      list_lines_and_dir_with_index

      #receives the input from user to select from an available list of rail lines
      @get_line = gets.strip.to_i
      # until @get_line.between?(1, list_lines.length)
      #   puts "Lets try this again"
      #   list_lines_and_dir_with_index
      #   @get_line = gets.strip.to_i
      # end
      until @get_line.between?(0, list_dir.length+list_lines.length)
        puts "Try again."
        @get_line = gets.strip.to_i
      end
      #----------------------------if they choose to search with rail lines------------------------------------------------------
      if @get_line.between?(1,list_lines.length)

        list_of_train_based_on_line


      #-----------------------if they choose to search by direction in first option-----------------------------------------------------
      elsif @get_line.between?(list_lines.length+1, list_dir.length+list_lines.length)

        list_of_trains_based_on_direction

      else
        restart

      end

#-------------------------------------choose to start search by choosing from list of stations---------------------------------
    elsif get_start == 2

      pick_from_list_of_all_stations

 #-----------------------if they choose to see all trains, from first option-------------------------------------------
    else
      list_all_trains

    end
  end
#---------------------------------------end of call function ----------------------------------------------------------

#---------------------------------------initialize method--------------------------------------------------------------
  def marta_import(key)
    MartaTrainScheduleImporter.new(key).import
  end

#---------------------------------------choosing from line or direction methods------------------------------------------------

  def list_lines
    RailLine.list_lines
  end
  def list_dir
    RailLine.list_direction
  end
  def list_lines_and_dir_with_index
    list_lines.each.with_index(1){|element, index| puts "#{index}: #{element} Line \n--------------"}
    list_dir.each.with_index(list_lines.length+1){|element, index| puts "#{index}: #{element} Line \n--------------"}

  end

                #----------------------line methods----------------------------------
  def list_stations_from_line(input)
    puts "\nHere is the available list of stations on the line you chose.\n"
    puts "Choose the station by typing the corresponding number:"

    @@rail = RailLine.list_lines[input-1]
    @@station = RailLine.find_station_from_line(@@rail).uniq
    RailLine.find_station_from_line(@@rail).sort.each.with_index(1){|element, index| puts "\n#{index}: #{element}\n-----------------------"}

  end

  def list_trains_from_station(input)

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

  end

  def list_of_train_based_on_line
    #put puts a list of train stations based on the rail line chosen
    list_stations_from_line(@get_line)

    #receives the input from user to select from an available list of stations based on a rail line
    get_station = gets.strip.to_i

    if !get_station.between?(1, @@station.length)
        puts "Lets try this again:"
        list_of_trains_based_on_line
    else
      list_trains_from_station(get_station)
    end
    puts "\nType 1 to restart and anything else to end:\n"
    get_end = gets.strip.to_i
    restart if get_end == 1
  end


                      #------------------choose train by direction methods---------------------------------
  def list_of_trains_based_on_direction
    #put puts a list of train stations based on the rail line chosen
    list_stations_from_direction(@get_line)

    #receives the input from user to select from an available list of stations based on a rail line
    get_station = gets.strip.to_i

    if !get_station.between?(1, @@station.length)
        puts "Lets try this again:"
        list_of_trains_based_on_line
    else
      list_trains_from_station_and_dir(get_station)
    end
  end

  def list_stations_from_direction(input)
    puts "\nHere is the available list of stations from the direction you chose.\n"
    puts "Choose the station by typing the corresponding number:"

    @@direction = list_dir[input-list_lines.length-1]
    @@station = RailLine.list_stations_from_direction(@@direction).sort
    RailLine.list_stations_from_direction(@@direction).each.with_index(1){|element, index| puts "\n#{index}: #{element}\n-----------------------"}


  end

  def list_trains_from_station_and_dir(input)

    @@station = @@station.sort[input-1]
    puts "\nHere are a list of incoming trains for #{@@station} on the #{@@direction} line:\n"
    puts ""

    Station.find_self_and_trains(@@station).select{|hash| hash['dir'] == @@direction}.each.with_index(1) do |element, index|
      puts "#{index}: Destination: #{element['destination']}\n"
      puts "   Direction: #{element['dir']}\n"
      puts "   Base Time: #{element['event_time']}\n"
      puts "   Waiting Time: #{element['waiting_time']}\n"
      puts "   Line: #{element['line']}\n"
      puts "----------------------------"
    end
    puts "\nType 1 to restart and anything else to end:\n"
    get_end = gets.strip.to_i
    if get_end == 1
      restart
    end
  end

#-----------------------------list all stations, from first options option 2-------------------------------------------------------------------
  def list_stations
    Station.all.collect{|obj| obj.name}.sort
  end

  def list_stations_with_index
    list_stations.each.with_index(1){|element, index| puts "#{index}: #{element}"}
  end

  def pick_from_list_of_all_stations
    puts "Here is a list all stations."
    puts "Pick one by typing its corresponding number and press enter:\n"
    list_stations_with_index
    get_station = gets.strip.to_i
    if !get_station.between?(0, list_stations.length)
      puts "Lets try this again."
      sleep(1)
      pick_from_list_of_all_stations
    elsif get_station.between?(1, list_stations.length)
      @@station = list_stations[get_station-1]
      puts "\nHere is the list of incoming trains for #{@@station}:\n\n"
      Station.all.find{|obj| obj.name == @@station}.incoming_trains.each.with_index(1) do |element, index|
        puts "#{index}: Destination: #{element['destination']}\n"
        puts "   Direction: #{element['dir']}\n"
        puts "   Base Time: #{element['event_time']}\n"
        puts "   Waiting Time: #{element['waiting_time']}\n"
        puts "   Line: #{element['line']}\n"
        puts "----------------------------"

      end

      puts "\nType 1 to restart and anything else to end:\n"
      get_end = gets.strip.to_i
      restart if get_end == 1
    else
      restart
    end
  end

#------------------------------list all trains, from first set of options, option three-----------------------------------------------

def list_all_trains
  Train.all.sort{|a,b| a.destination <=> b.destination}.each.with_index(1) do |element, index|
    puts"\n"
    puts "#{index}:  Destination: #{element.destination}"
    puts "    Base time: #{element.event_time}"
    puts "    Line: #{element.line}"
    puts "    Direction: #{element.dir}"
    puts "    Incoming Stations:"
    element.station.each{|hash| puts "Station: #{hash['station']}\nWait Time: #{hash['waiting_time']}\n-----------------------------------\n"}
  end
  puts "\nType 1 to restart and anything else to end:\n"
  get_end = gets.strip.to_i
  restart if get_end == 1
end

#------------------------------other methods ------------------------------------------------------------
  def refresh
    if @@rail != "" && @@station != "" && @@trains != []

    end
  end

  def restart
    Station.clear
    Train.clear
    RailLine.clear
    MartaAPIController.new("").call
  end

end
