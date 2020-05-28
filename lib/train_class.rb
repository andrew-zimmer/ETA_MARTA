class Train
    attr_accessor :id, :dir, :destination, :line, :station, :event_time

    @@all = []

    def initialize(id, destination, event_time, line, direction)
        @id = id
        @destination = destination
        @line = line
        @dir = (direction)
        @station = []
        @event_time = event_time

        @@all << self
    end

    def self.all
        @@all
    end

    def station(stations="", waiting_time="")
        new_hash = {}
        if stations != "" && waiting_time != ""
            Station.create(stations)
            new_hash['station'] = stations
            new_hash['waiting_time'] = waiting_time
            @station << new_hash
        end
        @station
    end

    def self.create(hash)
        RailLine.create(hash['LINE'])
        if self.all.find{|object| object.id == hash['TRAIN_ID']}
            old_object = self.all.find{|object| object.id == hash['TRAIN_ID']}
            old_object.station(hash['STATION'], hash['WAITING_TIME'])
        else
            new_object = self.new(hash['TRAIN_ID'], hash['DESTINATION'], hash['EVENT_TIME'], hash['LINE'], hash['DIRECTION'])
            new_object.station(hash['STATION'], hash['WAITING_TIME'])
        end

    end

    def self.clear
        self.all.clear
    end


end
