(ns drunken-cockroach.core
  (:require [drunken-cockroach.point :as point])
  (:require [drunken-cockroach.rectangle :as rectangle])
  (:require [drunken-cockroach.cockroach :as cockroach])
  (:require [drunken-cockroach.collection-utilities :as collection]))


(defn -main [& args]
  (let [
     origin    (point/create 1 1)
     corner    (point/create 5 5)
     floor     (rectangle/create origin corner)
     start     (point/create 1 1)
     visited   []
     times     (cockroach/walk_within floor start visited)]
  (println "that took me: " times " times")))

;  results = []
;  10.times do
;    rectangle = Rectangle.new origin_point: Point.new(1,1), corner: Point.new(5,5)
;    c.walk_within rectangle, Point.new(1,1)
;    results.push c.number_of_steps
;  end
