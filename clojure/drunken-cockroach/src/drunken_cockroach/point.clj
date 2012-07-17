(ns drunken-cockroach.point
  (:refer-clojure :exclude [max min]) )

(defstruct point :x :y)

(defn create [x y] (struct point x y))

(defn add [point1 point2]
  (let [
    x1 (get point1 :x)
    x2 (get point2 :x)
    y1 (get point1 :y)
    y2 (get point2 :y)]

  (struct point
    (+ x1 x2)
    (+ y1 y2))))

(defn max [point1 point2]
  (let [
    x1 (get point1 :x)
    x2 (get point2 :x)
    y1 (get point1 :y)
    y2 (get point2 :y)]

  (cond
      (> y2 y1) point2
      (> x2 x1) point2
      :else point1)))

(defn min [point1 point2]
  (let [
    x1 (get point1 :x)
    x2 (get point2 :x)
    y1 (get point1 :y)
    y2 (get point2 :y)]

  (cond
      (< y2 y1) point2
      (< x2 x1) point2
      :else point1)))
