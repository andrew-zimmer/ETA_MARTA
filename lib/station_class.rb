class Station
    attr_accessor :name, :incoming_trains, :directions

    @@all = []

    def initialize(name)
        @name = name
        @incoming_trains = []
        @directions = []
        @@all << self
    end

    def self.all
        @@all.each{|obj| obj.add_trains_info}
        @@all
    end

    def incoming_trains
        @incoming_trains
    end

    def self.find_self_and_trains(input)
        self.all.find{|obj| obj.name == input}.incoming_trains
    end

    def self.find_stations_by_direction(direction)
        self.all.select{|obj| obj.directions.include?(direction)}.collect{|obj| obj.name}.sort
    end

    def find_trains
        Train.all.select{|obj| obj.station.find{|hash| hash['station'] == self.name}}
    end

    def add_trains_info
        self.find_trains.each do |obj|
            # if !self.incoming_trains.any?{|hash|hash['train_id'] == obj.id}
                new_hash = Hash.new
                new_hash["train_id"] = obj.id
                new_hash['line'] = obj.line
                new_hash['dir'] = obj.dir
                new_hash['destination'] = obj.destination
                new_hash['event_time'] = obj.event_time
                new_hash['waiting_time'] = obj.station.find {|hash| hash['station'] == self.name}['waiting_time']
                @incoming_trains << new_hash
                if !self.directions.include?(obj.dir)
                    @directions << obj.dir
                # end
            end
        end
        self.incoming_trains.uniq!{|hash| hash['train_id']}
    end

    def self.create(station)
        if self.all.any?{|obj| obj.name == station}
            old_obj = self.all.find{|obj| obj.name == station}
            old_obj.add_trains_info
        else
            Station.new(station).add_trains_info
        end
    end

    def self.clear
        self.all.clear
    end


end
