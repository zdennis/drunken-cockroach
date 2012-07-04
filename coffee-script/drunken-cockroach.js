(function() {
  var Comparable, DrunkenCockroach, Point, Rectangle, Tile, c, extend, sets, _;
  extend = require('xtend');
  sets = require('simplesets');
  _ = require('underscore');
  Comparable = {
    compareTo: function(other) {
      throw "Must supply where included to return -1, 0, or 1!";
    },
    isEqualTo: function(other) {
      return this.compareTo(other) === 0;
    },
    isGreaterThan: function(other) {
      return this.compareTo(other) === 1;
    },
    isLessThan: function(other) {
      return this.compareTo(other) === -1;
    }
  };
  Point = (function() {
    extend(Point.prototype, Comparable);
    function Point(x, y) {
      this.x = x;
      this.y = y;
    }
    Point.prototype.plus = function(otherPoint) {
      return new Point(this.x + otherPoint.x, this.y + otherPoint.y);
    };
    Point.prototype.compareTo = function(other) {
      if (other.x > this.x || other.y > this.y) {
        return -1;
      } else if (other.x === this.x && other.y === this.y) {
        return 0;
      } else {
        return 1;
      }
    };
    Point.prototype.max = function(other) {
      if (this.isGreaterThan(other)) {
        return this;
      } else {
        return other;
      }
    };
    Point.prototype.min = function(other) {
      if (this.isLessThan(other)) {
        return this;
      } else {
        return other;
      }
    };
    return Point;
  })();
  Rectangle = (function() {
    function Rectangle(_arg) {
      this.originPoint = _arg.originPoint, this.corner = _arg.corner;
    }
    Rectangle.prototype.width = function() {
      return this.corner.x;
    };
    Rectangle.prototype.height = function() {
      return this.corner.y;
    };
    return Rectangle;
  })();
  Tile = (function() {
    extend(Tile.prototype, Comparable);
    function Tile(_arg) {
      this.location = _arg.location, this.floorArea = _arg.floorArea;
    }
    Tile.prototype.neighborAt = function(deltaPoint) {
      var actually_moving_to, new_tile, wants_to_move_to;
      new_tile = new Tile({
        floorArea: this.floorArea
      });
      wants_to_move_to = this.location + deltaPoint;
      actually_moving_to = wants_to_move_to.max(this.floorArea.originPoint).min(this.floorArea.corner);
      new_tile.location = actually_moving_to;
      return new_tile;
    };
    Tile.prototype.compareTo = function(other) {
      if (other.location.isEqualTo(this.location)) {
        return 0;
      } else {
        return -1;
      }
    };
    return Tile;
  })();
  DrunkenCockroach = (function() {
    function DrunkenCockroach() {
      this.tilesVisited = [];
    }
    DrunkenCockroach.prototype.directions = function() {
      var directions, x, y;
      directions = [];
      for (x = -1; x <= 1; x++) {
        for (y = -1; y <= 1; y++) {
          directions.push(new Point(x, y));
        }
      }
      return this.directions = function() {
        return directions;
      };
    };
    DrunkenCockroach.prototype.walkWithin = function(rectangle, startingPoint) {
      var delta_point, directions, index, number_of_tiles, tile_set, _results;
      this.tilesVisited = [];
      this.tile = new Tile({
        location: startingPoint,
        floorArea: rectangle
      });
      number_of_tiles = rectangle.width() * rectangle.height();
      this.tilesVisited.push(this.tile);
      tile_set = new sets.Set(this.tilesVisited);
      directions = this.directions();
      _results = [];
      while (tile_set.size() < number_of_tiles) {
        index = Math.random() * directions.length + 1;
        delta_point = directions[index];
        this.tile = this.tile.neighborAt(delta_point);
        _results.push(this.tilesVisited.push(this.tile));
      }
      return _results;
    };
    DrunkenCockroach.prototype.numberOfSteps = function() {
      return this.tilesVisited.length;
    };
    DrunkenCockroach.prototype.timesSteppedOn = function(tile) {
      return console.log("timesSteppedOn is not yet implemented");
    };
    return DrunkenCockroach;
  })();
  c = new DrunkenCockroach;
}).call(this);
