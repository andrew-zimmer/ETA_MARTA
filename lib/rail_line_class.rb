class RailLine
    attr_accessor :name, :stations, :dir

    @@all = []

    def initialize(name)
        @name = name
        @stations = []
        @dir = []
        @@all << self
    end

    def self.all
        @@all
    end

    def self.list_lines
        self.all.sort{|a,b| a.name <=> b.name}.collect{|obj| obj.name}
    end

    def self.list_direction
        self.all.collect{|obj| obj.dir}.flatten.uniq.sort
    end

    def self.find_station_from_line(line)
        self.all.find{|obj| obj.name == line}.stations
    end

    def self.list_dir_for_line(line)
        self.all.find{|obj| obj.name == line}.dir.sort
    end

    def find_station
        Station.all.select{|obj| obj.incoming_trains.find{|hash| hash['line'] == self.name}}
    end

    def add_station_info
        array = self.find_station
        array.each do |obj|
            if !self.stations.include?(obj.name)
                self.stations << obj.name
            end
            obj.incoming_trains.each do |hash|
                if hash['line'] == self.name
                    if !self.dir.include?(hash['dir'])
                        self.dir << hash['dir']
                    end
                end
            end
        end
    end


    def self.create(line)
        if self.all.any?{|obj| obj.name == line}
            old_obj = self.all.find{|obj| obj.name == line}
            old_obj.add_station_info
        else
            RailLine.new(line).add_station_info
        end
    end

    def self.clear
        self.all.clear
    end
end
