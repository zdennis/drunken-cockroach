(ns drunken-cockroach.core
  (:use drunken-cockroach.point))

(defn -main [& args]
  (println (drunken-cockroach.point/point :x 5 :y 6)))
