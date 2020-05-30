HELLO WORLD
# CliProject

With this gem you'll be able to search for trains based off rail-line, direction of travel, or station. You'll also be able given the option to see list of all trains that are currently in opertion.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cli_project'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cli_project

## Usage

You'll need to require a key for MARTA's API by sending a request from MARTA's website. Then use your key with the run file in the arguement for the MartaAPIController method and within the MartaAPIController class in the restart method.

When the app is initialized, you will be brought to the main menu where you will see the following options: 1. To search by rail-line or direction 2. To search by all availible stations 3. To see a list of all trains currently in operation. You choose all options with the corresponding number next to that option and press enter. At the point you get to see the trains you wanted, you'll be given the option to enter 1 and press enter and that will restart the program, making a new call to the api and creating a new instance and deleting the old one, updating the information for all stations and trains.

From the first option from the main menu, you'll be brought to a second menu with options listing the rail-lines that currently have trains running on them and a list of cardinal directions, again that only have trains that are traveling in the direction. By choosing one of the rail-lines, it will give you a list of stations that are on that rail-line that has a train schedule to arrive their. From there you will pick the station you are looking for, which will print out a list of trains that are currently on the rail-line you chose earlier and headed to the station you also chose. Each element in the list will have the final destination of that train, its base time(the time the api received the information), the direction of travel and an estimated time of arrival.
Choosing from the list of cardinal directions will give you list of stations that currently have a train heading towards them from that direction you chose. After making your choice out of list of stations, a list of all trains heading towards that station in the direction you chose from earlier.

From the second option from the main menu, you'll be printed out a list of all stations that currently have trains headed towards them. These stations of course will be numbered, and to choose the station you'll type the corresponding number and press enter and you'll be given a list of trains headed towards that station at the given time of that api call and from any direction. You'll be given the option to enter 1 and press enter to restart the program or press anything to end the program.

From the third option from the main menu, you'll be printed out a list of all trains currently on any and all tracks. Each element will give you the train's destination, id number, base time, and the list of stations that are currently on that trains route with an eta. From here you'll be given the option to enter one and press enter or to enter anytihng else to end the program.



## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/'persistent-modal-0577'/cli_project. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CliProject project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/'persistent-modal-0577'/cli_project/blob/master/CODE_OF_CONDUCT.md).
