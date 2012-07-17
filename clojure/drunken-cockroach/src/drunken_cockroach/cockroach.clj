(ns drunken-cockroach.cockroach
  (:require [drunken-cockroach.point :as point])
  (:require [drunken-cockroach.rectangle :as rectangle])
  (:require [drunken-cockroach.collection-utilities :as collection]))

(defstruct journey :number_of_steps)

(declare directions)

(defn take_random_step [rect point visited]
  (let [
    delta_point (collection/random-item directions)]
    (println "delta: " delta_point)))

(defn walk_within [rect point visited]
  (let [
    visited_set (into #{} visited)
    num_visited (count visited_set)
    num_tiles   (* (rectangle/width rect) (rectangle/height rect))]

    (println num_tiles)
    (println "visited: " num_visited " tiles: " + num_tiles)
    (if (= num_visited num_tiles)
      (struct journey num_visited)
      (take_random_step rect point visited))
    (int num_visited)))

(def directions (for [x [-1 0 1] y [-1 0 1]] (point/create x y)))

; (loop [i 1]
;       (println (str "on " i " iteration"))
;       (if (= i 10)
;         (println "done")
;         (recur (+ i 1))))

; def walk_within(rectangle, starting_point)
;   @tiles_visited = []    
;   @tile = Tile.new location: starting_point, floor_area: rectangle
;   number_of_tiles = (rectangle.width) * (rectangle.height)
;   @tiles_visited.push @tile
;   while @tiles_visited.to_set.length < number_of_tiles
;     delta_point = directions[rand(directions.length)]
;     puts "at #{@tile.location} by #{delta_point} is #{@tile.neighbor_at(delta_point).location}"
;     @tile = @tile.neighbor_at delta_point
;     @tiles_visited.push @tile
;   end
; end