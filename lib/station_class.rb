class Station
    attr_accessor :name, :trains, :event_time

    @@all = []

    def initialize(name)
        @name = name
        @trains = []
        @@all << self
    end

    def self.all
        @@all
    end

    def trains
        array = Train.all.select do |obj|
            obj.station.each{|hash| hash['station'] = station}
        end
        binding.pry
        @trains
    end

    def self.create(station)
        if self.all.find{|obj| obj.name == station}
            old_object = self.all.find{|obj| obj.name == station}
            old_object
        else
            self.new(station)
        end
    end


end
