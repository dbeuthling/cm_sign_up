class Camper
  attr_reader :name

  def initialize(name, buddy_number)
    @name = name
    @buddy_number = buddy_number
  end

  def self.activities(camper)
    puts "---#{camper.name}---"
    ObjectSpace.each_object(Activity) do |activ|
      puts "#{activ.title} - #{activ.period}" if activ.campers.include?(camper.name)
    end

  end

end

class Activity
  attr_reader :campers, :title, :period

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
    @campers.delete(boy.name) { "#{boy.name} is not listed in #{self.title}."}
  end

end

bill = Camper.new("Bill", "M10")
andy = Camper.new("Andy", "B5")
archery = Activity.new('Archery', 'first', 10)
archery.add_camper(bill)
archery.add_camper(andy)
tubing = Activity.new('Tubing', 'second', 6)
tubing.add_camper(andy)
# p archery.campers
# p tubing.campers
Camper.activities(andy)
Camper.activities(bill)
# archery.remove_camper(andy)
# p archery.campers
# Camper.activities(andy)
# p archery.remove_camper(andy)
