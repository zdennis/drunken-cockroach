class Class
  def initialize(*vars)
    keys = vars.map{ |k| k.to_s.sub(/^@/, '')}
    define_method :initialize do |*args|
      args = args.pop || {}
      args.each_pair do |k,v|
        raise ArgumentError, "Unexpected argument #{k}" unless keys.include?(k.to_s)
        instance_variable_set "@#{k}", v
      end
    end
  end
end

require 'set'

class Point
  include Comparable

  attr_reader :x, :y

  def initialize(x,y)
    @x, @y = x, y
  end

  def +(other)
    Point.new x + other.x, y + other.y
  end

  def max(other)
    other > self ? other : self
  end

  def min(other)
    other < self ? other : self
  end

  def <=>(other)
    if other.x > @x || other.y > @y
      -1
    elsif other.x == @x && other.y == @y
      0
    else
      1
    end
  end

  def hash
    "(#{@x}, #{@y})".hash
  end

  def to_s
    "(#{@x}, #{@y})"
  end
end

class Rectangle
  attr_reader :origin_point, :corner
  initialize :@origin_point, :@corner

  def width
    @corner.x
  end

  def height
    @corner.y
  end
end


# A tile refers to its row and column locations, each of which must be at least
# 1 and no larger than the width or length of the floor. Therefore, in 
# addition to remember its location, a Tile must remember the maximum
# floor space in which it can be placed.
class Tile
  attr_accessor :location, :floor_area

  initialize :@location, :@floor_area

  # Create and return a new tile that is at the location of the receiver
  # changed by the x and y amounts represented by the argument +delta_point+.
  # This new tile must be within the boundaries of the floor.
  def neighbor_at(delta_point)
    Tile.new(floor_area: floor_area).tap do |new_tile|
      wants_to_move_to   = (location + delta_point)
      actually_moving_to = wants_to_move_to.max(floor_area.origin_point).min(floor_area.corner)
      new_tile.location  = actually_moving_to
    end
  end

  def ==(other)
    other.is_a?(self.class) && other.location == location
  end
  alias_method :eql?, :==

  # TODO: this may not be needed
  def hash
    @location.hash
  end
end

class DrunkenCockroach
  def initialize
    @tile = Tile.new
    @tiles_visited = []
  end

  def directions
    @directions ||= Array.new.tap do |directions|
      (-1..1).each do |x|
        (-1..1).each do |y|
          directions.push Point.new(x,y)
        end
      end
    end
  end

  def walk_within(rectangle, starting_point)
    @tiles_visited = []    
    @tile = Tile.new location: starting_point, floor_area: rectangle
    number_of_tiles = (rectangle.width) * (rectangle.height)
    @tiles_visited.push @tile
    while @tiles_visited.to_set.length < number_of_tiles
      delta_point = directions[rand(directions.length)]
      puts "at #{@tile.location} by #{delta_point} is #{@tile.neighbor_at(delta_point).location}"
      @tile = @tile.neighbor_at delta_point
      @tiles_visited.push @tile
    end
  end

  def number_of_steps
    @tiles_visited.length
  end

  def times_stepped_on(tile)
    @tiles_visited.count(tile)
  end

end


c = DrunkenCockroach.new
results = []
10.times do
  rectangle = Rectangle.new origin_point: Point.new(1,1), corner: Point.new(5,5)
  c.walk_within rectangle, Point.new(1,1)
  results.push c.number_of_steps
end

puts results.inspect