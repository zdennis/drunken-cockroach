(ns drunken-cockroach.rectangle)

(defstruct rectangle :origin :corner :width :height)

(defn create [origin corner] (struct rectangle origin corner))

(defn width  [rect] (get (get rect :corner) :x))
(defn height [rect] (get (get rect :corner) :y))
