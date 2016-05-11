class Camper
  attr_reader :name

  def initialize(name, buddy_number)
    @name = name
    @buddy_number = buddy_number
  end

  def self.activities(name)
    ObjectSpace.each_object(Activity) do |activ|
      puts activ.title if activ.campers.include?(name)
    end

  end

end

class Activity
  attr_reader :campers, :title

  def initialize(title, period, capacity, campers=[])
    @title = title
    @period = period
    @capacity = capacity
    @campers = []
  end

  def full
    @campers.length >= @capacity
  end

  def add_camper(boy)
    full ? puts("#{self.title} is full.") : @campers << boy.name
  end

  def remove_camper(boy)
    @campers.delete(boy.name) { "#{boy.name} is not in the list."}
  end

end

bill = Camper.new("Bill", "M10")
andy = Camper.new("Andy", "B5")
archery = Activity.new('Archery', 'first', 10)
archery.add_camper(bill)
archery.add_camper(andy)
tubing = Activity.new('Tubing', 'second', 6)
tubing.add_camper(andy)
p archery.campers
p tubing.campers
Camper.activities("Andy")
archery.remove_camper(andy)
p archery.campers
Camper.activities("Andy")
