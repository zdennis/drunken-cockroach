extend = require 'xtend'
sets   = require 'simplesets'
_      = require 'underscore'

Comparable =
  compareTo: (other) ->
    throw "Must supply where included to return -1, 0, or 1!"

  isEqualTo: (other) ->
    @compareTo(other) == 0

  isGreaterThan: (other) ->
    @compareTo(other) == 1

  isLessThan: (other) ->
    @compareTo(other) == -1

class Point
  extend @prototype, Comparable

  constructor: (@x, @y) ->

  plus: (otherPoint) ->
    new Point(@x + otherPoint.x, @y + otherPoint.y)

  compareTo: (other) ->
    if other.x > @x || other.y > @y then -1
    else if other.x == @x && other.y == @y then 0
    else 1

  max: (other) ->
    if @isGreaterThan(other) then @ else other

  min: (other) ->
    if @isLessThan(other) then @ else other


class Rectangle
  constructor: (attrs = {}) ->
    @originPoint = attrs.originPoint
    @corner      = attrs.corner

  width: -> @corner.x
  height: -> @corner.y

class Tile
  extend @prototype, Comparable

  constructor: (attrs = {}) ->
    @location  = attrs.location
    @floorArea = attrs.floorArea

  neighborAt: (deltaPoint) ->
    new_tile           = new Tile floorArea: @floorArea
    wants_to_move_to   = @location.plus deltaPoint
    actually_moving_to = wants_to_move_to.max(@floorArea.originPoint).min(@floorArea.corner)
    new_tile.location  = actually_moving_to
    new_tile

  compareTo: (other) ->
    if other.location.isEqualTo(@location) then 0
    else -1

  toString: ->
    "(#{@location.x},#{@location.y})"


class DrunkenCockroach
  constructor: ->
    @tile = new Tile
    @tilesVisited = []

  directions: ->
    directions = []
    for x in [-1..1]
      for y in [-1..1]
        directions.push new Point(x,y)
    @directions = -> directions
    directions

  walkWithin: (rectangle, startingPoint) ->
    @tilesVisited   = []
    @tile           = new Tile location: startingPoint, floorArea: rectangle
    number_of_tiles = rectangle.width() * rectangle.height()

    @tilesVisited.push @tile
    directions = @directions()

    computeSet = =>
      simple_types = _.map @tilesVisited, (t) -> t.toString()
      new sets.Set simple_types

    while computeSet().size() < number_of_tiles
      index = parseInt(Math.random() * directions.length)
      delta_point = directions[index]
      @tile = @tile.neighborAt(delta_point)
      @tilesVisited.push @tile

  numberOfSteps: ->
    @tilesVisited.length

  timesSteppedOn: (tile) ->
    console.log "timesSteppedOn is not yet implemented"
    #@tilesVisited.count(tile)


c = new DrunkenCockroach
results = []
for num in [1..10]
  rectangle = new Rectangle
    originPoint: new Point(1,1)
    corner: new Point(5,5)
  c.walkWithin rectangle, new Point(1,1)
  results.push c.numberOfSteps()

console.log results
