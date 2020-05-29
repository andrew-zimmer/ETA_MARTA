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

    def station=(hash)
        Station.create(hash['station'])
        @station << hash
    end

    def self.create(hash)
        RailLine.create(hash['LINE'])
        if self.all.find{|object| object.id == hash['TRAIN_ID']}
            old_object = self.all.find{|object| object.id == hash['TRAIN_ID']}
            new_hash = {}
            new_hash['station'] = hash['STATION']
            new_hash['waiting_time'] = hash["WAITING_TIME"]
            old_object.station = new_hash
        else
            new_object = self.new(hash['TRAIN_ID'], hash['DESTINATION'], hash['EVENT_TIME'], hash['LINE'], hash['DIRECTION'])
            new_hash = {}
            new_hash['station'] = hash['STATION']
            new_hash['waiting_time'] = hash["WAITING_TIME"]
            new_object.station = new_hash
        end

    end

    def self.clear
        self.all.clear
    end


end
