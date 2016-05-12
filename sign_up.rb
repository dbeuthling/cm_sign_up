class Camper
  attr_reader :name

  def initialize(name)
    @name = name
    # @buddy_number = buddy_number
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

  def add_camper(camper)
    full ? puts("#{self.title} is full.") : @campers << camper.name
  end

  def remove_camper(camper)
    @campers.delete(camper.name) { "#{camper.name} is not listed in #{self.title}."}
  end

end

class Day

  def self.activity_participants(period)
    period_hash = {}
    ObjectSpace.each_object(Activity) do |activ|
      period_hash[activ.title] = activ.campers if activ.period == period
    end
    puts "---#{period.capitalize} Period---"
    period_hash
  end

  def add_campers
    campers = {}
    loop do
      puts "What is the name of the camper to add?"
      camper = gets.chomp.downcase
      puts "What is the camper's buddy nubmer?"
      buddy_number = gets.chomp.to_sym
      campers[buddy_number] = camper
      puts "Again? (y/n)"
      again = gets.chomp
      break unless again == 'y'
    end
    p campers
  end


end

m10 = Camper.new("Bill")
b5 = Camper.new("Andy")
archery = Activity.new('Archery', 'first', 10)
archery.add_camper(m10)
archery.add_camper(b5)
tubing = Activity.new('Tubing', 'second', 6)
tubing.add_camper(b5)
# p archery.campers
# p tubing.campers
# Camper.activities(andy)
# Camper.activities(bill)
# archery.remove_camper(andy)
# p archery.campers
# Camper.activities(andy)
# p archery.remove_camper(andy)
p Day.activity_participants('first')
p Day.activity_participants('second')
today = Day.new
today.add_campers
