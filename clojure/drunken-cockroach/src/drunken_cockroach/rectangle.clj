(ns drunken-cockroach.rectangle)

(defstruct rectangle :origin :corner)

(defn width  [rect] (get (get rect :corner) :x))
(defn height [rect] ((get rect :corner) :y))
